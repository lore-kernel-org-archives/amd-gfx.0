Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37B3C636CA
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80EF361182
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80EF361182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519DD6E063;
	Sun, 18 Jul 2021 14:06:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69E7B89E0D
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gbskkJMuz4D7TJA/XBFSa5eZY9CNHJ0BvmzdQhJouSsgTSEv9VPc7lO+khz0ZZwpwLRCo1kUAkhrHHpaRPijEW38vUMNGIOhWU1oWRWMgfjOw6SnPrgIjj2DzZZpG1gUlDFkWavrjmukLqxhg+ftNTmr+kovsXADWMrst9fMITHyEJRtOZO26hEMDtpA1MOg+8XNr0OQB1CqothxFnzEmAZcgbutw/rsFd4qEQXgvuyG9wca4+/tOzcgXkC1cmG7vxkoTzV3LBvns0XqiO9LSd8c5rHBQJAD5G1RMd7PXHq/4yg9NZRPrtbnJWZguF+62JuPqjTPZ3P5LcpmoFcAvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+tSODak6mGQ+5kw1/4vJQSXgdqnkWn5teAIU7QNfHo=;
 b=oPsYruiodiy3sEJ4hYPE0e4zsfeB9xeIVz0DNu7v/vcSrnPbhon/QBFPE4x9dBAgsiPPz2F31Mu+OI48PkYD6NEzeTnTfgKjcFoGBsXSRLDR1hrB+og7o3eRoo5LQxCQcDz1bu0rlAv2vmMq1bAq95H3AIceZiPnYDZAfLx+rmnqGgL6EvdhmLUXF3RYNOLjO66ZREQuiRkr5YMnKkUJGHqeQb/G7mCueluT2omovd3X5TDbIevVX7powsd8Mk8mCaYQxQ4bnvzVbH1WooU2P1sM7hNiEbu7ZGLsUG6/LUdGFAyz0AnCbNEcJ34PV5DHcZt/VoP7ajNnwxpO79TsgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+tSODak6mGQ+5kw1/4vJQSXgdqnkWn5teAIU7QNfHo=;
 b=Ih4CfvdeExnEgDPlFt39cHaB2oB49WDJS8SVpytBdtdcZuuuDHhX+nlnTue8cl72+rlzUKdOvXkQ2QbNpZP9VAhKhT6kNi7uVQ5MPw/3kJ8YSAus4CZmAXp97LrfuQNkdjUmuN5rZvPF3fPcTy3feudsO9WeFJh0SlyDU5CnblI=
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Sun, 18 Jul
 2021 14:06:23 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::13) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.11 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:23 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:21 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/32] DC Patches July 18, 2021
Date: Sun, 18 Jul 2021 10:05:38 -0400
Message-ID: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7054d0d4-8c4c-4a6c-3aed-08d949f5399e
X-MS-TrafficTypeDiagnostic: MN2PR12MB4552:
X-Microsoft-Antispam-PRVS: <MN2PR12MB45523033142CD8E6C79E4FFC98E09@MN2PR12MB4552.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 421rhaLkJAMKraPDHJPmlkK50SAGk3Q9vnLn2/wL9Z2GJL0ZRJWkM3nH+0QCwEE38i5ZsS2T2ShKUSybK5YG1cWt3tWtKmfRMsjQqwYMWL6sRxpqDKu58vJJFIU5ggjbXkAJ+6lCk2m3VLOOS4cQ+me5Gmwm0Pajlyus+Q57ApVUQGfxwkfQ44AHlvVenx0pKm1/0lwEhAJSl6RWeoaY5YMH3LZuzvPu48ds4afBSTY6zF6FUrfcjQrbPGu11FPYmjuabJHCWS0wkfubZ3eADmlrJ4GR24znoHid1yKRIEUvFvrJIe+1F5Nfc9lBUzsE6jvEEZQZcSmb/mKPlLaYHKJaipL/UgJ6Tm1v2yejbEsbYxfA1l6sM7zV+y4m/sZ1mddZM8BMOLBXhGGNGXVZvoLLYKBGJ8dlKZSHmngX9G7SOJRsaq2HvTQ3qWN0s+jdrYoIdbUq1q/vdiOS6hh2JbS5jkH7tjN9OlFhC7+5Sn7/zz5gqRaNjzdmBfizccLZSxLwIs/2SpGt367JFjblnqhAYEAzhyFr5SUr5SLvZxYq21MxGx4hD8TnaVkYW051JDOfQNItIx+ogbBRwzgOKNtZ56+rHV59rsO+j5RiJavtv0BIDlC4D5tq6rJvmdtdOJsIhtiSwkG9xv0P4c0S0NrhKblNQgyHipZLQ/rbv0HQyxMTGiGNWxCvl79+Xl1LxQb/LtzWrnyFXnR4Vf+/+US8Kfj8LViWaduVD/ylOYM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(81166007)(36756003)(426003)(5660300002)(2616005)(82310400003)(70586007)(478600001)(1076003)(70206006)(336012)(316002)(8676002)(54906003)(47076005)(8936002)(86362001)(186003)(16526019)(26005)(356005)(2906002)(6666004)(82740400003)(83380400001)(6916009)(4326008)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:23.0402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7054d0d4-8c4c-4a6c-3aed-08d949f5399e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

DC version 3.2.144 brings improvements in multiple areas. In summary, we
highlight:

- Code improvements for passive
- Cursor manipulation enhancements
- Expand debug in some areas
- Fix problems in DML
- Other minor code refactors

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.73
  drm/amd/display: [FW Promotion] Release 0.0.75

Aric Cyr (3):
  drm/amd/display: 3.2.143
  drm/amd/display: 3.2.144
  drm/amd/display: 3.2.145

Aurabindo Pillai (1):
  drm/amd/display: add debug print for DCC validation failure

Bindu Ramamurthy (2):
  drm/amd/display: Populate socclk entries for dcn3.02/3.03
  drm/amd/display: Populate dtbclk entries for dcn3.02/3.03

Camille Cho (1):
  drm/amd/display: Only set default brightness for OLED

Charlene Liu (1):
  drm/amd/display: reset dpcd_cap.dpcd_rev for passive dongle.

Dmytro Laktyushkin (1):
  drm/amd/display: remove compbuf size wait

Eric Yang (3):
  drm/amd/display: implement workaround for riommu related hang
  drm/amd/display: add workaround for riommu invalidation request hang
  drm/amd/display: change zstate allow msg condition

Ian Chen (1):
  drm/amd/display: Extend dmub_cmd_psr_copy_settings_data struct

Jake Wang (1):
  drm/amd/display: Fixed hardware power down bypass during headless boot

Josip Pavic (1):
  drm/amd/display: log additional register state for debug

Krunoslav Kovac (2):
  drm/amd/display: Assume active upper layer owns the HW cursor
  drm/amd/display: Refine condition for cursor visibility

Michael Strauss (1):
  drm/amd/display: Enable eDP ILR on DCN2.1

Mikita Lipski (2):
  drm/amd/display: Prevent Diags from entering S2
  drm/amd/display: Remove MALL function from DCN3.1

Nevenko Stupar (1):
  drm/amd/display: Line Buffer changes

Nicholas Kazlauskas (3):
  drm/amd/display: Fix max vstartup calculation for modes with borders
  drm/amd/display: Query VCO frequency from register for DCN3.1
  drm/amd/display: Update bounding box for DCN3.1

Oliver Logush (1):
  drm/amd/display: Fix timer_per_pixel unit error

Stylon Wang (1):
  drm/amd/display: Re-enable "Guard ASSR with internal display flag"

Victor Lu (1):
  drm/amd/display: Fix comparison error in dcn21 DML

Wesley Chalmers (1):
  drm/amd/display: Add copyright notice to new files

Zhan Liu (1):
  drm/amd/display: Reduce delay when sink device not able to ACK 00340h
    write

sunglee (1):
  drm/amd/display: DCN2X Prefer ODM over bottom pipe to find second pipe

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  4 ++
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |  2 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  | 59 ++++++++++++---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.h  | 54 --------------
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  8 +++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 72 +++++++++++++------
 .../drm/amd/display/dc/core/dc_link_dpcd.c    | 25 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h           | 12 ++--
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  1 +
 .../gpu/drm/amd/display/dc/dce/dce_hwseq.h    |  4 +-
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  7 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   | 19 ++++-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 29 ++++++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  4 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 42 ++++++-----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  6 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  2 +
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.c   | 21 ++++++
 .../drm/amd/display/dc/dcn20/dcn20_hubbub.h   | 33 +++++----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 17 +++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  6 ++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 60 +++++++++++-----
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.c   |  1 +
 .../drm/amd/display/dc/dcn21/dcn21_hubbub.h   | 14 +++-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |  2 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.c  | 16 -----
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dpp.h  |  3 +-
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.c   |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hubbub.h   | 14 +++-
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 25 +++----
 .../drm/amd/display/dc/dcn301/dcn301_hubbub.c |  1 +
 .../amd/display/dc/dcn302/dcn302_resource.c   | 13 +++-
 .../amd/display/dc/dcn303/dcn303_resource.c   | 13 +++-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.c   | 25 ++++++-
 .../drm/amd/display/dc/dcn31/dcn31_hubbub.h   | 15 +++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    | 23 +++++-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.h    |  1 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  3 +-
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  4 ++
 .../dc/dml/dcn21/display_mode_vba_21.c        |  2 +-
 .../amd/display/dc/dml/display_mode_structs.h |  2 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  | 14 ++++
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |  3 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  1 +
 .../gpu/drm/amd/display/dc/inc/link_dpcd.h    | 25 +++++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 40 +++++------
 48 files changed, 542 insertions(+), 215 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
