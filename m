Return-Path: <SRS0=3/5X=CT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530C5C43461
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2DDA21D81
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2020 13:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PhSr2nDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2DDA21D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 539BD6E92A;
	Thu, 10 Sep 2020 13:47:27 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750043.outbound.protection.outlook.com [40.107.75.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E186E92A
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2020 13:47:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgOUhMHud36HRToaUysmO6BIUgHrxe42y2hcmTaL5491/j0dNnR/BNcH2p4706Bb4q/cOguX/hvdmFXqqrjYUCr7Zqd2CDox6DoSMPmHTHtgrvsHBUkwshzhv7kTccnGHSSR9ocv4oCekX07FTYbkPPUv2BYG9pyhViYQ0ZVaoDCCm3AjMUUiMC0lB8Q81Prf7jSzxi3z+pORqnAakFcLcr/R8vC4bAO3TH+xpDZwNfikGVR7KrH+JBWvHpyhpkAumMk4uTIHYlAVlfwMf2Vv3VnUYKwwSxH1u4595BxGjOXOtEQD+6QQ0RhVQJ2QcWd2TQmZ9HTW4ai27Z5Oxe0XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7fXJX9JI4RGpaxBVGqkAtUoRG5sDB5tsaA8L/SFDS4=;
 b=EaX5QFu3pG0Gx3Irq9vG/iqL4Em3byZGbZWR+y4hRzuAYZNZAgjFZMOeXy2o+D5yP4UEyOzI8ON371hNcRZsdIH6veJiD1xVW4xWrzJc9cdvJ29IfMjU34xR1LXTdrjY369pzpqJxEKqzajz+o5lmiDUGf/1O96qpe8cf9IxyS1gMgEsxLGNkmOzXLvDaWdsml3PaC6AWWFUnKnly3sqDSDOb50pTwDgsCsiLUBXbZZU9iyp5kJ3pTJi8URDYr2+jglCu/iOZJUllX5XsrEHj3s2gdWG/yY0vIV0zyqR2vcUkLGMfwg76Z6D35lv+TQR7i34gtsuj/ul1Q4Xtfr3gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7fXJX9JI4RGpaxBVGqkAtUoRG5sDB5tsaA8L/SFDS4=;
 b=PhSr2nDzay2yRJDtyU+Y+IM5vFhohBrwSvhmFh67Z/Gf1FSfvX3j4d6c57t7NtmDAaed+nAxqJIp1zehQhXn2vyaMU64RYNrbuP8sPQkLvkZA36WbbNqwdwF+H42fveg7zZo5g1d3eHUdMQjU62YqIy0+dNZgZfTUKzvZjHcd2s=
Received: from BN8PR16CA0010.namprd16.prod.outlook.com (2603:10b6:408:4c::23)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 13:47:24 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::a5) by BN8PR16CA0010.outlook.office365.com
 (2603:10b6:408:4c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 13:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 13:47:24 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 10 Sep
 2020 08:47:23 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Thu, 10 Sep 2020 08:47:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/42] DC Patches Septemper 14, 2020
Date: Thu, 10 Sep 2020 09:46:41 -0400
Message-ID: <20200910134723.27410-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6580e02e-fbb5-463f-77b9-08d855900c48
X-MS-TrafficTypeDiagnostic: SA0PR12MB4477:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4477A04EF564CA178CB7662E8B270@SA0PR12MB4477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjP+FfgRJz+29VmlCXr5/HiLMdr0D8L5HXuIuFH6zeKSc5nXA7d3wH+v9z3kYyVIJw5mXaC06vXqf15GEVa+xOPVfTHfgtzGx6uiANGHu0WbG7Im4xtqfdUM27SJsYR033md6898N0gWEYa3OSoNlWaF8x2rwJnpV2KrArPr9NC1n3b4E3KJpAcn+lMz4/7RE1bTFg+9vLpDUQhOuYXZi5dOHy5C6lujhQfXhTtafSy5p4tMB9/J6i7BLjKSf8mruroCfHULpXWA3X2A5DVkid8yMi/wnlj9tDTikoVqtAdeNRRvi+zu+ocyEqywBaAH1lnnIR1xfnCkkywBWWnqNxCftaNLzN7bEUEhY/ORkGd5091tDT0sm6tilX8oFVB+rjR4ZaU09YvCG7ULWpJcqvLtHB7qj1wxDaLGrDo5HUA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(2616005)(70206006)(70586007)(8676002)(5660300002)(44832011)(426003)(36756003)(356005)(4326008)(82310400003)(83380400001)(26005)(2906002)(6666004)(54906003)(6916009)(82740400003)(1076003)(86362001)(8936002)(81166007)(47076004)(316002)(186003)(478600001)(7696005)(336012)(357404004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 13:47:24.2202 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6580e02e-fbb5-463f-77b9-08d855900c48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* DC Version 3.2.102
* DMUB Firmware release 0.0.32
* DSC improvements
* PSR enablement for DCN3
* Various bug fixes and improvements for eDP, OLED panel and others

--

Aidan Gratton (1):
  drm/amd/display: Increase Max EDID Size Constant

Alvin Lee (1):
  drm/amd/display: Compare plane when looking for pipe split being lost

Anthony Koo (3):
  drm/amd/display: [FW Promotion] Release 0.0.30
  drm/amd/display: [FW Promotion] Release 0.0.31
  drm/amd/display: [FW Promotion] Release 0.0.32

Aric Cyr (6):
  drm/amd/display: 3.2.100
  drm/amd/display: Triplebuffering should not be used by default
  drm/amd/display: 3.2.101
  drm/amd/display: Flip pending check timeout due to disabled hubp
  drm/amd/display: Multi display cause system lag on mode change
  drm/amd/display: 3.2.102

Ashley Thomas (1):
  drm/amd/display: Power eDP panel back ON before link training retry

Bhawanpreet Lakha (1):
  drm/amd/display: Don't use DRM_ERROR() for DTM add topology

Dmytro Laktyushkin (2):
  drm/amd/display: make dcn20 stream_gating use a pointer for
    dsc_pg_control
  drm/amd/display: update dcn30_optc header with missing declarations

Eric Yang (1):
  drm/amd/display: implement notify stream mask

Eryk Brol (5):
  drm/amd/display: Add DSC force disable to dsc_clock_en debugfs entry
  drm/amd/display: Add trigger connector unplug
  drm/amd/display: Return the number of bytes parsed than allocated
  drm/amd/display: Calculate DSC number of slices in debugfs when forced
  drm/amd/display: Add connector to the state if DSC debugfs is set

Fangzhi Zuo (1):
  drm/amd/display: Further fix of psr eDP p-state warning

George Shen (1):
  drm/amd/display: Rename set_mst_bandwidth to align with DP spec

Harmanprit Tatla (2):
  drm/amd/display: Add CP_IRQ clear capability
  drm/amd/display: Fix CP_IRQ clear bit and logic

JinZe.Xu (1):
  drm/amd/display: Detect plane change when detect pipe change.

Joshua Aberback (2):
  drm/amd/display: Compare mpcc_inst to mpcc_count instead of a constant
  drm/amd/display: Update idle optimization handling

Josip Pavic (1):
  drm/amd/display: remove dc context from transfer function

Jun Lei (2):
  drm/amd/display: update nv1x stutter latencies
  drm/amd/display: get socBB from VBIOS

Lewis Huang (1):
  drm/amd/display: update clock when non-seamless boot stream exist

Martin Leung (1):
  drm/amd/display: adding pathway to retrieve stutter period

Naveed Ashfaq (1):
  drm/amd/display: Fixed Intermittent blue screen on OLED panel

Rodrigo Siqueira (1):
  drm/amd/display: Check clock table return

Roman Li (2):
  drm/amd/display: remove early return from dm_late_init
  drm/amd/display: fix compile warning in dml

Wenjing Liu (2):
  drm/amd/display: add option to override cr training pattern
  drm/amd/display: always use 100us for cr aux rd interval

Wesley Chalmers (1):
  drm/amd/display: Only use offset for first ODM pipe

Zhan Liu (2):
  drm/amd/display: Enabling PSR on DCN30 on driver side
  drm/amd/display: Disable idle optimization when PSR is enabled

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 64 ++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 14 +++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 76 +++++++++++++----
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 30 +++----
 .../drm/amd/display/dc/bios/bios_parser2.c    | 71 +++++++++++++++-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  7 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 57 +++++++++----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  4 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 53 +++++++-----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  6 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 29 ++++---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 12 ++-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |  7 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  9 +-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  4 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 16 ++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 +-
 .../amd/display/dc/dce/dce_stream_encoder.c   |  6 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   | 84 ++++++++++++++-----
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  4 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c |  3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 14 ++--
 .../display/dc/dcn10/dcn10_stream_encoder.c   |  6 +-
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c |  3 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 33 +++++---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  6 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |  4 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  2 +
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |  4 -
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  4 +-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 29 +++----
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  5 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.h |  4 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 38 ++++++++-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 11 ++-
 .../dc/dml/dcn21/display_mode_vba_21.c        |  2 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        | 12 ++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  6 ++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  2 +-
 .../dc/virtual/virtual_stream_encoder.c       |  9 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  5 +-
 .../amd/display/include/bios_parser_types.h   |  6 ++
 .../amd/display/include/link_service_types.h  |  1 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  8 ++
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |  1 +
 .../drm/amd/display/modules/hdcp/hdcp_ddc.c   | 17 ++++
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |  2 +-
 50 files changed, 577 insertions(+), 220 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
