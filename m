Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D02C64EC4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:43:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D019810E6C0;
	Fri,  3 Mar 2023 15:43:56 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A963710E6C0
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:43:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCZjb/PE5QtcF1pZk45c7hyhhFsag+j1QOVVyfe0uPQjXIF+dhQrHrtecRMhH31mDBGHTk0ZVgb+BQ1GMNpN0+bIGzc6UW2cCyC8P0hGrpoDHKVrTq01sq1mGdGq/1oDcVSYFnfCGxlMU6GIwHdsDYvOoKCClIF6x0AS1i/OQh0DEpH/hhKwkhBhMZWZdvebpmIFzUNu7n7mgrwfnz9DAQHAIRmaczBkwRAWngbcHrvbSqcCZ7e4dr0JQ6EEUrbSsINmQNCgiPrIWBLoJBWx31wnu6f3QgT3Yh8dT7CisGV1OvHNSpiZrbN0ZVYKOWDze1+gQEK8Lvk49QptOSW8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3H47P+IOkDkD4nc4bKl9hsJC/kyAFaDylwhGlvZpnwE=;
 b=klnlrgOf1uLwMZFMdSzONp8lcif2jbhGuUhkMc/bqhObx+uDTcNF57LVm0nEFP8o3ANHdwfqALdnlb1UG3A25Cpz+wrds8NCa0crTeExo6JCruR3+EculWAfRVx2N3ZecJwqw8h4YI++d9BZ7+Ksw3fh9N/T6SC0uKNtjknPUIHmp3cOfMI6jXvwF+LcMRd2sAwWyiAykMtK7NdaioY7/O5M8G/TgDIiKT89Ynznc0urlM2yioLdJFUXzp7Dq00Jlxcsk1QmtkPhyGSSLw6tY0d2youYhjkrFaF4AClDbuERKajncnFXGDTRCK1qUZiMGlKbmM+sCFZUGl2bbDmv3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3H47P+IOkDkD4nc4bKl9hsJC/kyAFaDylwhGlvZpnwE=;
 b=2T1trp0/I1J05h7djFtEwZ8JVq1vsvRq8uRqEL1wlyTpM7KX014kXTzjCl7USjxvHMA8hd9Ti99AT23jE4gvrKKn+w9u+g3X7KGmpaefmgftSwyndZvi4rhOC1CVzsh6I5xi0MaS9rHJUJ7y+ozj1rt8o0rW5jnKLgPc3LOUbaM=
Received: from MW4PR02CA0026.namprd02.prod.outlook.com (2603:10b6:303:16d::25)
 by DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.21; Fri, 3 Mar
 2023 15:43:53 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::23) by MW4PR02CA0026.outlook.office365.com
 (2603:10b6:303:16d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.22 via Frontend
 Transport; Fri, 3 Mar 2023 15:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.22 via Frontend Transport; Fri, 3 Mar 2023 15:43:52 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:43:42 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/33] DC Patches Mar 6th, 2023
Date: Fri, 3 Mar 2023 10:39:49 -0500
Message-ID: <20230303154022.2667-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d76c74-fb75-4ada-07ac-08db1bfe1750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I0EV9lZkZnVx17pp5d98fjCy3VvdY20Az9E+EsnW0U/pi8ZhJztW5cTW70b1qDtrVwuhoC1VgnANvmmiWaSso5j1iKS5zbHU3tik+JZu7YVlKSNSvyyIYUiTIvCaYVI54PyCL+QMwx1liCSR509p7Qjep3yTPIU+7vri698Cn/DTyx88KlA5VdZ1WCYSJQp8rmzQT8ro1SuL0pxRICAhG2Dm7806xQN/LwHyo60+2eR2SRVvqRq8ke4Yvya9JcTPF9QBeoVcPTgEu/yZYPDAhoByov9AjYca0CCZI4Lhet6WgqNlQ1vbh8uKrh62gRI+jZr/RFF5Ta3wnIUXRjTSBustj4lyLCbagcHqGDiEHnSGQNdg9EouUmaFr95u+4J59TSrg/K+zWQRJjuWrUY6OxyTgE+3GnbCnozkYdzhQyhxAkayxjWmYXqDbf7Nq+tt4szfA3k5lnaTddOYzdCUssO5KUovaNMg9CZbehljNn2xVQB84oYJtG8Qwvpo31dydH5RVZ1LIVn+KwoT3O1HbJ83ra23QRiDpAUSLFRdp4aywnusq++HIBTEifqOAN2l2AfhmPWO3dXIUr73H9k/JZ3I3sQ+hg5RAtaNPXhQ1c0kldogXZ17oWFk8TXOmwlZ3rfRscjqNdGHmpeDf6+kNznyY2xJb5uMsUeRhk1hpVLl1/mBeQ3g2Y7XljURkhq70zBni12TWc+jd5VGc6ABcqIfS3iCqBOkBHhAhw3G7B4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(36840700001)(40470700004)(46966006)(5660300002)(86362001)(8676002)(4326008)(6916009)(41300700001)(8936002)(70586007)(70206006)(356005)(316002)(2906002)(54906003)(44832011)(478600001)(82740400003)(82310400005)(81166007)(2616005)(1076003)(26005)(16526019)(426003)(47076005)(186003)(36756003)(36860700001)(40460700003)(336012)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:43:52.8258 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d76c74-fb75-4ada-07ac-08db1bfe1750
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

1) Transitioning to the new DC commit sequence

There is an extended effort to migrate to the new DC commit sequence
that better adheres to the DCN hardware constraints. Most of the code
was upstreamed already but not connected to amdgpu_dm, and in this new
DC version, our DM finally started to use it for all ASICs. This should
improve stability and enable us to improve how pipe split works.

2) Drop old CONFIG_DRM_AMD_DC_DCN in favor of new CONFIG_DRM_AMD_DC_FP

For historical reasons, we created CONFIG_DRM_AMD_DC_DCN to isolate
FPU-related code to only be used for DCN. Over the years, we lost
control over this guard, and it was spread in multiple areas. In this
new DC version, there is an effort to remove all unnecessary
CONFIG_DRM_AMD_DC_DCN and replace the others for CONFIG_DRM_AMD_DC_FP,
which better describes which type of code this guard is intended for.

Additionally, this patchset brings along the following:
- Enable HostVM based on rIOMMU active
- Keep PHY active for dp confi
- Improves Z8
- Update clock table
- Code and directives clean up

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

---

Agustin Gutierrez (1):
  drm/amd/display: Keep PHY active for dp config

Alvin Lee (3):
  drm/amd/display: When blanking during init loop to find OPP index
  drm/amd/display: Update to correct min FCLK when construction BB
  drm/amd/display: Pass tg and hubp inst instead of pipe index for SubVP

Aric Cyr (2):
  drm/amd/display: 3.2.225
  drm/amd/display: 3.2.226

Chris Park (1):
  drm/amd/display: Simplify register offsets

Gabe Teeger (1):
  drm/amd/display: Enable HostVM based on rIOMMU active

Harry Wentland (8):
  drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDR
  drm/amd/display: Fix no-DCN build
  drm/amd/display: Drop CONFIG_DRM_AMD_DC_HDCP
  drm/amd/display: call remove_stream_from_ctx from res_pool funcs
  drm/amd/display: Build DSC without DCN config
  drm/amd/display: Drop unnecessary DCN guards
  drm/amd/display: Drop unnecessary DCN guards
  drm/amd/display: Rename DCN config to FP

Mike Hsieh (2):
  drm/amd/display: Add height granularity limitation for dsc slice
    height calculation
  drm/amd/display: fix typo in dc_dsc_config_options structure

Mustapha Ghaddar (1):
  drm/amd/display: Unify DC logging for BW Alloc

Nicholas Kazlauskas (2):
  drm/amd/display: Add minimum Z8 residency debug option
  drm/amd/display: Update minimum stutter residency for DCN314 Z8

Rodrigo Siqueira (6):
  drm/amd/display: Ensure vmin and vmax adjust for DCE
  drm/amd/display: Drop dc_commit_state in favor of dc_commit_streams
  drm/amd/display: Use dc_update_planes_and_stream
  drm/amd/display: Use DC_LOG_DC in the trasform pixel function
  drm/amd/display: Add wrapper to call planes and stream update
  drm/amd/display: Ensure that planes are in the same order

Wayne Lin (1):
  drm/amd/display: Pass the right info to drm_dp_remove_payload

Wenjing Liu (5):
  drm/amd/display: move dc_link functions in accessories folder to
    dc_link_exports
  drm/amd/display: move dc_link functions in link root folder to
    dc_link_exports
  drm/amd/display: link link_dp_dpia_bw.o in makefile
  drm/amd/display: move dc_link functions in protocols folder to
    dc_link_exports
  drm/amd/display: replace all dc_link function call in link with link
    functions

 drivers/gpu/drm/amd/display/Kconfig           |  14 +-
 drivers/gpu/drm/amd/display/Makefile          |   4 -
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 150 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 -
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  11 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  65 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  39 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 129 ----
 drivers/gpu/drm/amd/display/dc/Makefile       |   7 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   8 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   5 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  90 +--
 .../drm/amd/display/dc/core/dc_link_exports.c | 294 ++++++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +-
 .../drm/amd/display/dc/core/dc_vm_helper.c    |   2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  35 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  10 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  66 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  11 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 579 ------------------
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   6 -
 .../drm/amd/display/dc/dce/dce_clock_source.c |  27 +-
 .../drm/amd/display/dc/dce/dce_clock_source.h |   6 -
 .../drm/amd/display/dc/dce/dce_transform.c    |   5 +-
 .../display/dc/dce110/dce110_hw_sequencer.h   |   2 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.c  |   5 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dwb.h  |   4 -
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   3 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 -
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   5 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   4 +-
 .../amd/display/dc/dcn314/dcn314_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.h |  36 --
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |   2 -
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |  64 --
 .../drm/amd/display/dc/dcn32/dcn32_hubbub.h   |  62 --
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |   6 -
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  83 +++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   4 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |  71 ---
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   3 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |   2 -
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   3 -
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   4 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   5 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |   6 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   6 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |   3 +-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  33 +-
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  |   2 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h   |   8 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   2 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |   2 +-
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     | 128 +++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   2 +-
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   2 +-
 .../display/dc/link/accessories/link_dp_cts.c |  47 +-
 .../display/dc/link/accessories/link_dp_cts.h |  19 +-
 .../dc/link/accessories/link_dp_trace.c       |  13 +-
 .../dc/link/accessories/link_dp_trace.h       |  12 +-
 .../drm/amd/display/dc/link/link_detection.c  |  16 +-
 .../drm/amd/display/dc/link/link_detection.h  |   6 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  20 +-
 .../drm/amd/display/dc/link/link_factory.c    |  84 ++-
 .../drm/amd/display/dc/link/link_resource.h   |   3 -
 .../drm/amd/display/dc/link/link_validation.c |   9 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |  24 +-
 .../amd/display/dc/link/protocols/link_ddc.h  |   3 +
 .../dc/link/protocols/link_dp_capability.c    |  58 +-
 .../dc/link/protocols/link_dp_capability.h    |  19 +
 .../display/dc/link/protocols/link_dp_dpia.c  |   2 +-
 .../display/dc/link/protocols/link_dp_dpia.h  |   4 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |  97 ++-
 .../dc/link/protocols/link_dp_dpia_bw.h       |  26 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  30 +-
 .../dc/link/protocols/link_dp_irq_handler.h   |  12 +-
 .../display/dc/link/protocols/link_dp_phy.c   |  10 +-
 .../display/dc/link/protocols/link_dp_phy.h   |   8 +-
 .../dc/link/protocols/link_dp_training.c      |  17 +-
 .../dc/link/protocols/link_dp_training.h      |   3 +
 .../link/protocols/link_dp_training_auxless.c |   2 +-
 .../link/protocols/link_dp_training_auxless.h |   2 +-
 .../dc/link/protocols/link_dp_training_dpia.c |   4 +-
 .../dc/link/protocols/link_dp_training_dpia.h |   2 +-
 .../link/protocols/link_edp_panel_control.c   |  31 +-
 .../link/protocols/link_edp_panel_control.h   |  20 +
 .../amd/display/dc/link/protocols/link_hpd.c  |  14 +-
 .../amd/display/dc/link/protocols/link_hpd.h  |   4 +
 drivers/gpu/drm/amd/display/dc/os_types.h     |   4 +-
 .../{hdcp_types.h => hdcp_msg_types.h}        |   0
 .../drm/amd/display/modules/hdcp/hdcp_log.h   |   2 -
 .../amd/display/modules/power/power_helpers.c |   7 -
 103 files changed, 1216 insertions(+), 1585 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_link.h
 rename drivers/gpu/drm/amd/display/include/{hdcp_types.h => hdcp_msg_types.h} (100%)

-- 
2.34.1

