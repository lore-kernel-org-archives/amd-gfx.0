Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33771C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B160B10E7E8;
	Fri,  3 Feb 2023 15:25:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A1910E7E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R53mEuxPdkJsZfHYzfnMDFkx9qRqGcItttSNf+1V/D8AbF9mqjBY/SFYK2+rfPA4t+cOnF3dawFqohYOxay2ltEQ4mQ7r9pdtDE5N+WZkq1WUoPwZtecl2feC/AIZy6Z25Fn0IQEUuF+02tgZI6WPvok0kRmjqMmI/PZITlk2A8Uko527EGk/n7pAq0RtzTknB33Ni9IdEnrHMTIsSdtsG0JKpxH5zjn6U+ZGb2I6NMo3d5QRc8263Y54juQJLry85tGfFGyk+5IFu0CW1PJI1pULUPjB5Txx/jktiXc0/9vC5Mrg1hKr6DB+aa6ItSJ0Js4sPjI3QqvkmcrjiM3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlDCKLhYcKcWbhzkh6b9W4j3VQEIDpCrERF7ZdZK4EM=;
 b=V9UXBVFeDqPo5Z7o0uJ4aENmmB7ZxQp048snOKGEFMOvcXaLDAlcJnV109ovhdP4bVAFXrH3kDilN9cyUHce55egVMmx5plkrMR3IttempffGQCxOWatjBInl34cYkxKHBfV/BEbZi8iTL0i6mZsT8CFdkPl7HEPld5HJHwh7EO50QzUr+XokyVAgmUQckCBGXcSQ+p09zfb2syF4HuRNkp9LMSDDAV6UMaUxD5Fi3en0EhkkOl1z3juknXoPXkk39ojDrGle7Vs0+vLiy/MAtmW4q6SmzwVTgVDLK+3mWBBtLsVUdxrh9CUc2koR4wxA2m0AXI7VYKqllJE0K2Q5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlDCKLhYcKcWbhzkh6b9W4j3VQEIDpCrERF7ZdZK4EM=;
 b=2AnWoAse3zcQgxUshDX2OwRjeOCM9oZancHIZF1N8V1NUL2702ePUstc9ByU62wVuiMu+D1xB839dXc4gII4NK9n1Vr6cbREYSHibgxJ04TqxGe3Iuerz2E/TAWNiefXK/B8ryvjOT5mR1oLy3UW6jIZoXkWQSOopJxMlRb+Nx4=
Received: from MN2PR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:23a::15)
 by IA1PR12MB6531.namprd12.prod.outlook.com (2603:10b6:208:3a4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Fri, 3 Feb
 2023 15:25:25 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::4c) by MN2PR03CA0010.outlook.office365.com
 (2603:10b6:208:23a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:24 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:22 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/12] DC Patches Feb 6th, 2023
Date: Fri, 3 Feb 2023 10:24:40 -0500
Message-ID: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|IA1PR12MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbf3d0b-edb2-4e2a-1764-08db05fadf43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HAwTovwjICgY3Xt91lw8WR3/5nT6lxqoxdwRcHrAQCaHfwhE+/26+tL9u6eftc1UFfQKRL6fHQn32yK4qZisj/N7BVh3iE/pg9sveQTfM+LOOUtgvNc7cFJ5aEoM4S/px2mFGAtBL0qo/1ECYm4FO7OYjznvyxmI3Tzj29f+qV2obo7MNyw2mPOaO76ekK0lydBYNCB7EtJ/QmMVBdy7d4YBZhqqR9kWR8rXFVNVRcFCXLR6XKu0bxhMk20Ot5P6ZQsp0KwWILCbrTuAXjYjVS5Vhv0TU45wcsacDsat16rSYuGjYovBr5fulStLsHb/txtXc8Y02tCph5n2auZ8OB8ciHTB9KULliN2F3XTMJXvBRjuLbnWxxRcUJWTartFqjMHskCD6NNmkWMfFwcqYcvasoluNYHITDBlI5kfTeSYUkgzV0xx7x4OPeoox8l0OJTfFudtAdwODVpHuNp0kk8MXu+ZNBkI6HE28m+vQhFlxuAGYvriIjNQh5X4OAgRocg3nhO2r0O3047wjBC+dWE6eDaXPQmGv7DBqP1+jB/aByaE1bgpaxICuPuhuhkHDTN6lh5NEHbCbh+GlT/EqIceZAA4ilVvn3rlVo8V/ZVmATH+I1jEJckrHFu3kiPmze5IXmcDtX4g9FIBFeCakDYgbPG/xJxS+tnZifpzUW6UJfOnK6bo4iH3SuOfGgHQCFfJV0eWR3F6qbDld5qfqCePYRUME0tTebPmgYoUfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(8936002)(2616005)(54906003)(5660300002)(4326008)(316002)(2906002)(41300700001)(8676002)(70206006)(70586007)(6916009)(26005)(6666004)(478600001)(1076003)(16526019)(186003)(83380400001)(336012)(426003)(82310400005)(356005)(81166007)(47076005)(44832011)(36756003)(40480700001)(86362001)(82740400003)(36860700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:24.8110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbf3d0b-edb2-4e2a-1764-08db05fadf43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6531
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
 
- DC 3.2.222
- FW 0.0.153.0
- Code re-organize for dc_link.c
- Bug fixes on rotation, DRR and more
- DCN314 domain power control moved to dmcub
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>
---

Alvin Lee (1):
  drm/amd/display: Set max vratio for prefetch to 7.9 for YUV420 MPO

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.153.0

Aric Cyr (1):
  drm/amd/display: 3.2.222

Aurabindo Pillai (1):
  drm/amd/display: Fix null pointer deref error on rotation

Hans de Goede (1):
  drm/amd/display: Drop CONFIG_BACKLIGHT_CLASS_DEVICE ifdefs

Jingwen Zhu (1):
  drm/amd/display: avoid disable otg when dig was disabled

Leo (Hanghong) Ma (1):
  drm/amd/display: Add HDMI manufacturer OUI and device id read

Nicholas Kazlauskas (1):
  drm/amd/display: Move DCN314 DOMAIN power control to DMCUB

Wenjing Liu (1):
  drm/amd/display: break down dc_link.c

Wesley Chalmers (3):
  drm/amd/display: Do not set DRR on pipe commit
  drm/amd/display: Do not commit pipe when updating DRR
  drm/amd/display: Only raise FP2 outside of lock

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   15 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |    2 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   26 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   37 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4873 +----------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    8 +-
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |   20 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   69 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   12 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |    4 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |    9 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |    5 +-
 .../display/dc/dcn10/dcn10_stream_encoder.c   |    6 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   43 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c |    1 +
 .../display/dc/dcn20/dcn20_stream_encoder.c   |    2 +-
 .../drm/amd/display/dc/dcn201/dcn201_optc.c   |    1 +
 .../drm/amd/display/dc/dcn21/dcn21_hwseq.c    |    6 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |    5 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   10 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |    2 +
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |    8 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_optc.c |    1 +
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |    2 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |   24 +
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |    2 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |    2 +-
 .../drm/amd/display/dc/dcn314/dcn314_optc.c   |    1 +
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |    2 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |    4 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |    1 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |    2 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   32 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |    8 +-
 .../dc/dml/dcn32/display_mode_vba_32.h        |    3 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   12 +-
 .../amd/display/dc/dml/display_mode_structs.h |    1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |    1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |    1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   27 -
 .../amd/display/dc/inc/hw/timing_generator.h  |    2 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   32 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    9 +-
 .../display/dc/link/accessories/link_dp_cts.c |    4 +-
 .../dc/link/accessories/link_dp_trace.c       |    9 +-
 .../dc/link/accessories/link_dp_trace.h       |    1 +
 .../display/dc/link/accessories/link_fpga.c   |   95 +
 .../display/dc/link/accessories/link_fpga.h   |   30 +
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |   16 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |    4 +-
 .../drm/amd/display/dc/link/link_detection.c  | 1356 +++++
 .../drm/amd/display/dc/link/link_detection.h  |   30 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 2395 ++++++++
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |   35 +
 .../drm/amd/display/dc/link/link_factory.c    |  577 ++
 .../drm/amd/display/dc/link/link_factory.h    |   29 +
 .../drm/amd/display/dc/link/link_resource.c   |  149 +
 .../drm/amd/display/dc/link/link_resource.h   |   29 +
 .../drm/amd/display/dc/link/link_validation.c |  396 ++
 .../drm/amd/display/dc/link/link_validation.h |   28 +
 .../dc/link/protocols/link_dp_capability.c    |   68 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |    1 +
 .../dc/link/protocols/link_dp_irq_handler.c   |   12 +-
 .../dc/link/protocols/link_dp_irq_handler.h   |    4 -
 .../display/dc/link/protocols/link_dp_phy.c   |   83 +-
 .../display/dc/link/protocols/link_dp_phy.h   |    4 +
 .../dc/link/protocols/link_dp_training.c      |    3 +-
 .../dc/link/protocols/link_dp_training_dpia.c |    3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   27 +-
 73 files changed, 5660 insertions(+), 5071 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_detection.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_detection.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dpms.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_factory.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_factory.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_resource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_resource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_validation.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_validation.h

-- 
2.25.1

