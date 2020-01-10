Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5925EC33CA3
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FF752082E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 14:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Tp8yTR9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FF752082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4D66EA33;
	Fri, 10 Jan 2020 14:47:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91CF36EA2C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 14:47:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktlLQSqHR9E/Z4eFKnH2KWWq2GF2QZ5aWja23R/U4ENpVNxarpYoRL3P6hRAoJl4fjL6wKrdrnIvNQbrD6tvwptbpMgKV6kRRvazUPSblEt4serf2NXuO4xJquhsVSQXqjCuhvd/R3uQIsKZrB5H1NSc6Sg/ddZTtWrZskSJYL4UqqAEjl7QFRLHGIyJLV/uUXlWNmaoHpwamGIr4keYPXkz40wxaE4pQ5UTfHmCcrf7KGnHB67RPi8ZkLLX6ypRdJyXMFm6DZQsbtnXqp4dtzkEC0C+k2dWRDkyYCvBh3rAs2b3wMiYBn7WZuvxx7pq/od0eyQS6WmR5R9KINjHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq3LXgDF1jZ7Hpe2Admrb3z48V7ksgTNxEtRSREwLZI=;
 b=E3t4UEPL/R4a63x9Ix5hwGffqF4THzkdJo0Gi+eDkDrDSz4zwmWCrSA5pzHfWMUBMNmTUzC99zzRrLpSiVwafurZzm3BFQIk3L8fMp22RjjGDhQRuI/iIypKx/oiC0TOuWDrLVCCNMnBCC4qYubVwX00JGUU8QRWq//AyIWv5pUDzcQVLm+TcFCwPCSZe0jwXp2UhP4b2F90FsuGlAvAKGE3w24LI0SXfbPmiBKS1TvBJJnGbYVw3wej19UxfifQo8GCQbcOSGI1qCmkOJh6ekRQwif47a+2usVRxAV6LrBgXvR7yVocy8BEUjoZX+EyEnkGGna0Scku2S+qgxhHwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zq3LXgDF1jZ7Hpe2Admrb3z48V7ksgTNxEtRSREwLZI=;
 b=Tp8yTR9y5z5BXhPhxBP8SJpDYWV4EiZp/0OukboCs70K/l4T8gRBf7k4e1xUboSjyyjD+wYzzqyXn5PV/4w05qB5o0XvnBDEiDJVgrpSS4UGQp0yio0tBC7JqCCy26QBl8VuqxFU6B62XBhRuiWH7/T9WkxyNE35cDu/rHNIV6I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Fri, 10 Jan 2020 14:47:20 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::699c:a877:13ef:6ae2%6]) with mapi id 15.20.2623.011; Fri, 10 Jan 2020
 14:47:20 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 00/43] DC Patches - January 10, 2020
Date: Fri, 10 Jan 2020 09:46:12 -0500
Message-Id: <20200110144655.55845-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.1
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 14:47:20 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fdf5d74a-20ec-4eef-59c7-08d795dbfefc
X-MS-TrafficTypeDiagnostic: MW2PR12MB2524:|MW2PR12MB2524:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2524DE522F0878640ADACA5898380@MW2PR12MB2524.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(8936002)(5660300002)(6916009)(81156014)(6486002)(81166006)(36756003)(316002)(1076003)(2906002)(6666004)(956004)(7696005)(52116002)(478600001)(186003)(2616005)(86362001)(26005)(16526019)(66556008)(8676002)(66476007)(4326008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2524;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2eLa48rCvc0ynzXOQhNjlaR7uCD4ojXTeyBnJeTYtJHB1hfGUPEtDK3PyikLiQndnH7hqtN4f/7Ni1ztZ9ztSlRP8Jjs+PzQ4dH6mNLgL0G+1u2YSrs91R45GeaB18/kKNj53+Xb0PJYaMcqGo7mWouot71I0Baw8lAjcA8xWa7ApZvadEVhZof9b0/dAGbYgGJ+TyiBfeky4OTO/SI/0IPceuhezap0IUrZWll6UTjhQntoe/WiSR7ZDAc7cfk6uRIM8GBq8AiWS3v4zxSOpqmPuhPWqmab9EzBBwRj7sd8Ut9mR5xxRBo/mErPrhGlqRM4E5S0U4DBMOH6F9SNRY3r7qHxQbdFUvVX7g3OAi0gdYGgC91AF0tQaeG/Y7JsyV7eboIisNcRd3LFfwLIWCH2/VGDXKgi1hSctSpBlKHTYCnCaESlFTklzBWtEOc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdf5d74a-20ec-4eef-59c7-08d795dbfefc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 14:47:20.6360 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy+00JZzRB2Z0spgogpLsY3vVQ2QwWazwDErxtyxGkyu75wCfMS3yM20MFdq1nL46tJKZo9SERgaVK3gnESlhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2524
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

* Add OCSC improvements.
* Bug fix on chroma, Freesync dml, and DMUB.
* DMCUB improvements.
* Some code refactor.

Alvin Lee (3):
  drm/amd/display: Fix 300Hz Freesync bug
  drm/amd/display: Don't always set pstate true if dummy latency = 0
  drm/amd/display: Enable double buffer for OTG_BLANK

Amanda Liu (1):
  drm/amd/display: Clear state after exiting fixed active VRR state

Anthony Koo (1):
  drm/amd/display: make PSR static screen entry within 30 ms

Aric Cyr (4):
  drm/amd/display: 3.2.65
  drm/amd/display: 3.2.66
  drm/amd/display: 3.2.67
  drm/amd/display: 3.2.68

Charlene Liu (1):
  drm/amd/display: rename _lvp to l_vp

Chris Park (1):
  drm/amd/display: Add default switch case for DCC

Dmytro Laktyushkin (1):
  drm/amd/display: expand dml structs

Eric Yang (1):
  drm/amd/display: fix chroma vp wa corner case

George Shen (1):
  drm/amd/display: Add w/a to reset PHY before link training in
    verify_link_cap

Joseph Gravenor (1):
  drm/amd/display: stop doing unnecessary detection when going to D3

Josip Pavic (1):
  drm/amd/display: implement fw-driver interface for abm 2.4

Jun Lei (1):
  drm/amd/display: fixup DML dependencies

Lewis Huang (2):
  drm/amd/display: remove psr state condition when psr exit case
  drm/amd/display: Add monitor patch for AUO dpcd issue

Martin Leung (1):
  drm/amd/display: Adding forgotten hubbub func

Martin Tsai (1):
  drm/amd/display: Use udelay to avoid context switch

Michael Strauss (1):
  drm/amd/display: Update HDMI hang w/a to apply to all TMDS signals

Nicholas Kazlauskas (3):
  drm/amd/display: Flush framebuffer data before passing to DMCUB
  drm/amd/display: Read inst_fb data back during DMUB loading
  drm/amd/display: Soft reset DMUIF during DMUB reset

Nikola Cornij (1):
  drm/amd/display: Disable secondary link for certain monitors

Noah Abradjian (4):
  drm/amd/display: Add double buffering to dcn20 OCSC
  drm/amd/display: Fix double buffering in dcn2 ICSC
  drm/amd/display: Double buffer dcn2 Gamut Remap
  drm/amd/display: Indirect reg read macro with shift and mask

Paul Hsieh (1):
  drm/amd/display: reallocate MST payload when link loss

Rodrigo Siqueira (1):
  drm/amd/include: Add OCSC registers

Sung Lee (1):
  drm/amd/display: Use SMU ClockTable Values for DML Calculations

Wenjing Liu (3):
  drm/amd/display: wait for update when setting dpg test pattern
  drm/amd/display: wait for test pattern after when all pipes are
    programmed
  drm/amd/display: skip opp blank or unblank if test pattern enabled

Wyatt Wood (3):
  drm/amd/display: Driverside changes to support PSR in DMCUB
  drm/amd/display: DMCUB FW Changes to support PSR
  drm/amd/display: Fix DMUB PSR command IDs

Yongqiang Sun (3):
  drm/amd/display: programing surface flip by dmcub.
  drm/amd/display: Refactor surface flip programming
  drm/amd/display: Only program surface flip for video plane via dmcub

abdoulaye berthe (1):
  drm/amd/display: store lttpr mode with dpcd

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  32 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |  10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  13 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  64 +++-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  99 +++++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  10 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  20 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  30 ++
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   4 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   3 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 220 +++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |  47 +++
 .../display/dc/dce110/dce110_hw_sequencer.c   |  35 +-
 .../dc/dce110/dce110_timing_generator.c       |  11 +-
 .../dc/dce110/dce110_timing_generator.h       |   3 +-
 .../dc/dce120/dce120_timing_generator.c       |  11 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_cm.c   |  20 --
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.c   |   3 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  31 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  15 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   3 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  |  26 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.h  |  64 +++-
 .../drm/amd/display/dc/dcn20/dcn20_dpp_cm.c   | 155 ++++++++-
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   |   6 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  13 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  47 ++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.h  |  22 ++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  53 +++-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 300 ++++++++++--------
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  28 +-
 .../dc/dml/dcn20/display_mode_vba_20.c        | 169 +++++-----
 .../dc/dml/dcn20/display_mode_vba_20v2.c      | 171 +++++-----
 .../dc/dml/dcn21/display_mode_vba_21.c        | 161 +++++-----
 .../amd/display/dc/dml/display_mode_enums.h   |  18 +-
 .../amd/display/dc/dml/display_mode_structs.h |   7 +-
 .../drm/amd/display/dc/dml/display_mode_vba.c |  22 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h | 128 +++++---
 .../drm/amd/display/dc/dml/dml_common_defs.c  |   2 +-
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   1 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +
 .../display/dc/{calcs => inc}/dcn_calc_math.h |   0
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  20 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  20 ++
 .../amd/display/dc/inc/hw/timing_generator.h  |   3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 +-
 .../amd/display/dc/inc/hw_sequencer_private.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |  13 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  78 +++--
 .../drm/amd/display/dmub/inc/dmub_cmd_dal.h   |  15 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_rb.h    |  29 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_srv.h   |  19 --
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   6 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  57 ++--
 .../amd/display/modules/freesync/freesync.c   |   3 +
 .../amd/display/modules/power/power_helpers.c |   7 +-
 .../include/asic_reg/dcn/dcn_2_0_0_offset.h   |   4 +
 .../include/asic_reg/dcn/dcn_2_0_0_sh_mask.h  |   9 +-
 .../include/asic_reg/dcn/dcn_2_1_0_offset.h   |   5 +-
 .../include/asic_reg/dcn/dcn_2_1_0_sh_mask.h  |   8 +
 65 files changed, 1743 insertions(+), 651 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
 rename drivers/gpu/drm/amd/display/dc/{calcs => inc}/dcn_calc_math.h (100%)

-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
