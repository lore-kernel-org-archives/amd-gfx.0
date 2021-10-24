Return-Path: <SRS0=f4Zr=PM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A608C433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9DF6052B
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Oct 2021 13:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4F9DF6052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A0589F9F;
	Sun, 24 Oct 2021 13:32:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6435389F9F
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Oct 2021 13:32:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqb0eXxAq+Y0iaevMQIPQDI4+bJ/7BlAlpqlpFaCQeHpHIYVq4S/Yv1zPfR81IGlwzOVHmT72DJVhuUlqOM45Fcu96zJuAYA13gTHpgSCN90vHU9woMxoKMbg/G4QYqSkmIY1a+8v6Js8E5AIjq8a5XDVfuaCaJN5g+wAdUulb2wV1cyM4bwfVvxMxj3zl0837nmGiGDV/vFwttMJGYr0q7nRVRS6aHELp6E2iADMRmh7e0jl3HKYGG9bDJRUgUAQnMEtIQt/R3EvcmsVY7/Kr09XNr2SdW8k6+nh+sjC8ljrfIzMp7pvMYvAvLtCR9ylq+hBbeyjs0QKVCKnfYvng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66piyxiAv4IgM73rJ9JAXqzpOTKg1AY1P9Tbhno7vf8=;
 b=a+HQeGr3f+kgNX57hi1SOA2+WROXuhhR1B7P4HQHGCMakdqk1jylYifFTvHH56BvZW/k8IYvoaVU9UQ1pNYB7cpUxDYPnqQ5BOx4WOTSM487SX4dCbUdy+hUNj5hT9mBHW2WEiG8twELgWE4SLgP3cq9XhtxAag89uGlVbLuFExh444llC4Aego3pKyRxYNQ5vEqKwRMr+9uHd+Ii4IC75tir12Roomnm6UavszP7VCuhROAhuALI5LdeWGGY7q+AmOYhc/5obYLPMWlKAJcpJMrc176IiVw+6ASErOsBC4zKwtb5z5AKzPcm2B8mH1a+9XAeQgoyQK3JTtBa121Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=66piyxiAv4IgM73rJ9JAXqzpOTKg1AY1P9Tbhno7vf8=;
 b=cvK7MhiVOnJyRy14CAG2a0xzv+IE2pGd9RQ799NMvZWCvsr4TQwu1IkTg+uIll+Ym+6SFgc8o1V2tswm9Iys2OFcId50hVUi9C02j4+eNlHjF9XiETa1OTMRFIaW3fuJD+L5fDkVSeDX05Hi8sfLh+4dHji3r1cd6hGJWznAwMk=
Received: from MW2PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:302:1::17)
 by BYAPR12MB3623.namprd12.prod.outlook.com (2603:10b6:a03:a9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Sun, 24 Oct
 2021 13:32:09 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::f7) by MW2PR2101CA0004.outlook.office365.com
 (2603:10b6:302:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend
 Transport; Sun, 24 Oct 2021 13:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Sun, 24 Oct 2021 13:32:09 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Sun, 24 Oct
 2021 08:32:07 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, <pavle.kotarac@amd.com>,
 <agustin.gutierrez@amd.com>
Subject: [PATCH 00/33] DC Patches October 24, 2020
Date: Sun, 24 Oct 2021 09:31:08 -0400
Message-ID: <20211024133141.239861-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1952c19-9978-4656-4c3a-08d996f2ae14
X-MS-TrafficTypeDiagnostic: BYAPR12MB3623:
X-Microsoft-Antispam-PRVS: <BYAPR12MB362306AFA9E6A292116F973E98829@BYAPR12MB3623.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5E0iOBri5xedv1r+uMzEyQAYtC4UOGTJHRChaaXYApREy7otkMAtZcKMgrI5qOpEk0f0u5mDvSpC4Ei/dKVeWfxS28KPCvDvAGowjiaLbDtwuxQ8c5ehLmeS67zMS9F/NIA38/v6UFZIH+TfwtxCQiEid1D+dDUyt/gHBLSSP6z10fWel64Dqf9M20e2DjvCLgXuO7P39qYcZfGECQy32qQV8ym7LiRJRiBoZ9tGHF8BtrilZM8HYyXfX4SS0BT7QyQJseqFf2OE2Hhf3Gjf+nYUUsJ/VILS+Cz0MEZhPdFsQX9GIx+XyNuNVwCkxLDHsWC7d5zGnOKKWjcUe0yaHngaFqVllJC+ajui1hfemKGif0zqzY0c1k4I64ERy1grvj1/eBHhdiQt38zgk1KKOsCaLRpS8d5IUA+BMBH80HDcst1P1KjYuSwf4RjRvxfJr6DRKoZXuu8IC220vdRgVR6uXAVWpJxEjrVE43ifQiUbU87gbcAthTv8jVCgtj4zw29Wba3s67yVuNPAhgVPOy2uPv9VGtBMrQ6+f0yIay1t+p7XIQg4Z/LlTxSCpj+MWEbwyvX1c1rmcab4Yz2tSf7urd411lqKKp7g2DEmJ5E5H1TcoIA0PvM11s0OVc2Xkfys8GstMP/3n8uepWU5ZGTKXb0u6oxj51Zc9ca61H6tXPKBV4ooFtLya7rhNHVkxoGKzAN0R7NnumR//MR6ZRPpAGpHOa+uxPa1o5KAGkA=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(426003)(86362001)(83380400001)(26005)(70206006)(36860700001)(8676002)(47076005)(336012)(1076003)(186003)(5660300002)(54906003)(2616005)(36756003)(70586007)(316002)(356005)(4326008)(82310400003)(81166007)(2906002)(6916009)(16526019)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2021 13:32:09.4944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1952c19-9978-4656-4c3a-08d996f2ae14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3623
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

This new DC version brings improvements in the following areas:
- Improvements for USB4;
- Isolate FPU code for DCN20, DCN301, and DSC;
- Fixes on Linking training;
- Refactoring some parts of the code, such as PSR;

Thanks

Ahmad Othman (2):
  drm/amd/display: Add support for USB4 on C20 PHY for DCN3.1
  drm/amd/display: fix a crash on USB4 over C20 PHY

Anson Jacob (2):
  drm/amd/display: dcn20_resource_construct reduce scope of FPU enabled
  drm/amd/display: Remove unused macros

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.89
  drm/amd/display: [FW Promotion] Release 0.0.90

Aric Cyr (4):
  drm/amd/display: Handle I2C-over-AUX write channel status update
  drm/amd/display: 3.2.158
  drm/amd/display: Fix 3DLUT skipped programming
  drm/amd/display: 3.2.159

Dmytro Laktyushkin (3):
  drm/amd/display: clean up dcn31 revision check
  drm/amd/display: restyle dcn31 resource header inline with other asics
  drm/amd/display: allow windowed mpo + odm

George Shen (2):
  drm/amd/display: Implement fixed DP drive settings
  drm/amd/display: Add comment for preferred_training_settings

Guo, Bing (2):
  drm/amd/display: Get ceiling for v_total calc
  drm/amd/display: set Layout properly for 8ch audio at timing
    validation

Hansen (1):
  drm/amd/display: Set phy_mux_sel bit in dmub scratch register

Jimmy Kizito (1):
  drm/amd/display: Add workaround flag for EDID read on certain docks

Lewis Huang (1):
  drm/amd/display: Align bw context with hw config when system resume

Martin Leung (1):
  drm/amd/display: Manually adjust strobe for DCN303

Meenakshikumar Somasundaram (2):
  drm/amd/display: FEC configuration for dpia links
  drm/amd/display: FEC configuration for dpia links in MST mode

Michael Strauss (2):
  drm/amd/display: Set i2c memory to light sleep during hw init
  drm/amd/display: Defer GAMCOR and DSCL power down sequence to vupdate

Qingqing Zhuo (2):
  drm/amd/display: move FPU associated DSC code to DML folder
  drm/amd/display: move FPU associated DCN301 code to DML folder

Robin Chen (1):
  drm/amd/display: dc_link_set_psr_allow_active refactoring

Wenjing Liu (5):
  drm/amd/display: adopt DP2.0 LT SCR revision 8
  drm/amd/display: implement decide lane settings
  drm/amd/display: decouple hw_lane_settings from dpcd_lane_settings
  drm/amd/display: add two lane settings training options
  drm/amd/display: fix link training regression for 1 or 2 lane

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  10 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   2 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  16 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  17 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 118 ++++-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |  15 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 498 +++++++-----------
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  57 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  14 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  23 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   5 -
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  13 +-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |  34 +-
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |   3 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  20 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  12 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   6 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  19 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  |  14 +
 .../drm/amd/display/dc/dcn30/dcn30_dpp_cm.c   |   8 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  35 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |  26 -
 .../amd/display/dc/dcn301/dcn301_resource.c   | 349 +-----------
 .../amd/display/dc/dcn301/dcn301_resource.h   |   3 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |  14 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   4 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   5 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  11 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.h |  10 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |   2 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   6 +
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 390 ++++++++++++++
 .../amd/display/dc/dml/dcn301/dcn301_fpu.h    |  42 ++
 .../amd/display/dc/{ => dml}/dsc/qp_tables.h  |   0
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.c  | 291 ++++++++++
 .../drm/amd/display/dc/dml/dsc/rc_calc_fpu.h  |  94 ++++
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |  29 -
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.c  | 259 ---------
 drivers/gpu/drm/amd/display/dc/dsc/rc_calc.h  |  50 +-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   1 -
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  16 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   2 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  55 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   2 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 +
 .../display/include/grph_object_ctrl_defs.h   |   1 +
 .../amd/display/include/i2caux_interface.h    |   3 +
 .../amd/display/include/link_service_types.h  |  29 +-
 .../amd/display/modules/freesync/freesync.c   |  15 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   2 +
 55 files changed, 1529 insertions(+), 1134 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
 rename drivers/gpu/drm/amd/display/dc/{ => dml}/dsc/qp_tables.h (100%)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.h

-- 
2.25.1

