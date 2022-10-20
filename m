Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D0AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D2710E093;
	Thu, 20 Oct 2022 15:47:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F4AE10E093
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAo86omVzlCd273W/xpQr4IT/VFe1kjA9SMDp3HLYZLZGcdCQ5IyBnTkjFaXDmfs5TRdRwOs8Ag+KLjkjY02Pf3EpDA+01TseU+U8rutojq2UoMPpyvR76PIzM01sd1ra65q0dXmvv5OlXyZfweZrOGx+SCIP1b5ZoEQqX3kxKXNAEpdQ/bR/TCFuK+FLFBzTD6UPaenpQiomYCfqoQjDl5JuC4SaioNPVWSkHJSh9RQJSrDO05dExhPWV8MB/NHwOwd9v6UGXIA/pYbje9Fbi0R7a2ZUJ5yCQKd/ZS+yj++LUo/2qMecF5xXdvPaAHmI43Ha6cexA43cd0ME2j99g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN+6fzHAzQB0lh3i8wD1Zf1ejsBFU2pQoJmU002iRCU=;
 b=JRWaR84Qn9BxS4WnAlDGnUHU5dOv6t+2B3szt8mDT3l23qv9Rq2ZiFL2ytV7vWM3N23b5OC+1MLEMKs+GivHeijDlvarRwHlXg00IvR1epBaWes3sJzVBFBMYEmSeRRA1wrX8j4CCQGuj9EZYX7gYtHfjSGoU/79Vvu6MFuvC/bTolhRa+c0rSIg2vbe4SDeCqKSouDy0gW0EAI/+OdiNG+5esq5GG6l7b+K1HKutosH72leoU70kGMB3T6LzaUZRfpQeHHlLx8b80EKFSyNSeX82ttImcA6C67D310ZnDDy9tSx/pu46r+7KoDv3AjAU9kH4d0V77KsGl0dxF+Hvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN+6fzHAzQB0lh3i8wD1Zf1ejsBFU2pQoJmU002iRCU=;
 b=CNRNz8Rtxt4YEvvGzvHqaPlIU81K7wvsSpWyHt267NIhibf8Vg7FzNnvB+v4EXKac/fjv0ARO1cm+7ExEJ8vYZg7vrGTJMlGOLz+d0mL8BKvPdgoAUHwyTH/l14aknpYHgZ4Tfu9wWJpesaNl8Uoe8NhnUWx2fKwUV5xIznM4FA=
Received: from DS7PR03CA0339.namprd03.prod.outlook.com (2603:10b6:8:55::18) by
 BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 15:47:31 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::f5) by DS7PR03CA0339.outlook.office365.com
 (2603:10b6:8:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:30 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:29 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/33] DC Patches October 20th, 2022
Date: Thu, 20 Oct 2022 11:46:29 -0400
Message-ID: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT022:EE_|BN9PR12MB5083:EE_
X-MS-Office365-Filtering-Correlation-Id: e72f1bf3-9642-4f4f-fdb8-08dab2b265ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YX8mDQZDwpP8hql9e4XNDNyWY5Ox/tPHEoH+0XO66uzoanGPiB1e9doAxXiTpm2e1KmTF79pLfchcAozt/RwudEHCL45G3pUzcTTMlOHUWEMc9SEMgswaMa8YF8AyqTn3+Zd+CrDpbQAFWDSBvGKaKzdn9trZVuzohIvCVjfzpYz5L1IsvlwSlCmoPI2/iB6ZslRpPBAPjcT0cE+fuO6NTTU0icf3+I+wm6B3B26ANyaV60JYv2XQLjLLqVnpbKsR5WVNkVxtvl+hpewH6OOf2h1v4njcP62beKeVpk38obShOf9KZyphWuqHyvQbqD0XMNvljPlhrv4BiQZpq3J3eBRdY38COhwOzy9jsprPKFw6c3WusgtCCuVGS9DeYvA2hdudIQ+hVEHV69e/7A7dRbVkixsjm0L5P7Z4pEC4tlpOdiMSpggpJn9BzkT0AulwpZCuYdI5Skdu5yLDbdqZl3tjR04E1Ee42JUTZJ2VW0vM1U4mUSivMmdv9vjTY2aN2wUzNekvhLxCG/pHzxs+t04CmS8biS6KtVJDzmRgmEyJ5UtuBoICfcNOmvf5V+1PZShwQNUzv4DWt/rse2/9ktfgETrvVvRMzQes3bDilxfUhcNlw1jEi+z5nm9p7/FTSJZfodUyxZKQ2huswoPqYHruACjEsNjyCpDJyEh0ZeoRBB3ZyBygR/oHF57mlxmg2FnEg932oMJmTEvDFjAfCOSXs+7794i3Y2GQH7DcWJejiiusXWwE3GV7rCrsEVDkEaPAO42Di6uRhawL+ACjF0/EpB4Vh3Ok1bTtfpuoP+TUYlzADhLuMgZKZGAu2eu
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199015)(46966006)(40470700004)(36840700001)(36756003)(36860700001)(86362001)(40460700003)(4326008)(8676002)(82740400003)(8936002)(1076003)(2616005)(426003)(47076005)(40480700001)(16526019)(186003)(336012)(81166007)(356005)(83380400001)(6916009)(316002)(54906003)(7696005)(82310400005)(70206006)(5660300002)(70586007)(41300700001)(26005)(478600001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:30.9543 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e72f1bf3-9642-4f4f-fdb8-08dab2b265ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
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
Cc: stylon.wang@amd.com, Mark Broadworth <mark.broadworth@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Improve color manipulation
* Add corrections to DML and some flag configuration
* Expand kernel-doc
* Enable secure display on DCN21
* PSR code refactor
* Rework audio stream sequence

Cc: Mark Broadworth <mark.broadworth@amd.com>
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alan Liu (2):
  drm/amd/display: Implement secure display on DCN21
  drm/amd/display: Drop struct crc_region and reuse struct rect

Alvin Lee (2):
  drm/amd/display: Remove optimization for VRR updates
  drm/amd/display: Enable timing sync on DCN32

Anthony Koo (1):
  drm/amd/display: Document part of the DMUB cmd

Aric Cyr (3):
  drm/amd/display: 3.2.208
  drm/amd/display: Fix SDR visual confirm
  drm/amd/display: 3.2.209

Bhawanpreet Lakha (1):
  drm/amd/display: Fix HDCP 1.X 1A-04 failing

Dillon Varone (2):
  drm/amd/display: Update latencies on DCN321
  drm/amd/display: Set memclk levels to be at least 1 for dcn32

Dmytro Laktyushkin (1):
  drm/amd/display: correctly populate dcn315 clock table

Fangzhi Zuo (2):
  drm/amd/display: Add UHBR135 and UHBR20 into debugfs
  drm/amd/display: Ignore Cable ID Feature

Haiyi Zhou (1):
  drm/amd/display: wait for vblank during pipe programming

Ian Chen (1):
  drm/amd/display: Refactor eDP PSR codes

Jun Lei (1):
  drm/amd/display: Limit dcn32 to 1950Mhz display clock

Leo Chen (1):
  drm/amd/display: Update DSC capabilitie for DCN314

Lewis Huang (1):
  drm/amd/display: refine wake up aux in retrieve link caps

Ma Hanghong (1):
  drm/amd/display: Wrong colorimetry workaround

Max Tseng (1):
  drm/amd/display: cursor update command incomplete

Rodrigo Siqueira (8):
  drm/amd/display: Remove FPU guards from the DML folder
  drm/amd/display: Convert documentation to a kernel-doc
  drm/amd/display: Add events log to trace OPTC lock and unlock
  drm/amd/display: Expand kernel doc for DC
  drm/amd/display: Add DEC/CRB basic doc
  drm/amd/display: Add basic ODM description
  drm/amd/display: Add kernel doc to some of the dc fields
  drm/amd/display: Add kernel doc for commit sequence

Wenjing Liu (3):
  drm/amd/display: refactor enable/disable audio stream hw sequence
  drm/amd/display: move stream encoder audio setup to link_hwss
  drm/amd/display: remove audio mute control in hpo dp

zhikzhai (1):
  drm/amd/display: skip commit minimal transition state

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  15 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 153 +++++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |  12 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  57 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |  64 ++++++
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  71 ++----
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  11 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 203 +++++++++++-------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  13 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   6 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 162 ++++----------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  22 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  22 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 124 +++++------
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  22 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_trace.h     |   2 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   7 +
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |  14 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |  72 ++-----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |   5 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |   4 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  14 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  16 ++
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   5 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   9 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  15 +-
 .../amd/display/dc/dcn302/dcn302_resource.c   |  14 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |  13 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |  13 --
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.h  |   4 -
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |   9 -
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   4 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   6 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   4 +
 .../amd/display/dc/dcn316/dcn316_resource.c   |   4 +
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.c   |   4 +
 .../gpu/drm/amd/display/dc/dml/dc_features.h  |   7 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   3 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   2 -
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  17 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |  10 +-
 .../amd/display/dc/dml/display_mode_enums.h   |  25 +++
 .../drm/amd/display/dc/dml/display_mode_vba.h |   9 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  61 +++++-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  15 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/dmcu.h  |  16 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   7 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |   6 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |   5 +
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |   5 +
 .../drm/amd/display/dc/link/link_hwss_dio.c   |  52 +++++
 .../drm/amd/display/dc/link/link_hwss_dio.h   |   4 +
 .../drm/amd/display/dc/link/link_hwss_dpia.c  |   3 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    |  25 +++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  37 ++++
 .../amd/display/modules/inc/mod_info_packet.h |   3 +-
 .../display/modules/info_packet/info_packet.c |   6 +-
 62 files changed, 928 insertions(+), 613 deletions(-)

-- 
2.35.1

