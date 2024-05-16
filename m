Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A61FC25B78
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EE6010E413;
	Thu, 16 May 2024 19:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AXYc3iVp";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B301510E413
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l65VOmsM3Y/ChnoOFXCXB8Vpm9wnEHpEQ1upNBzS224bFb3UVaazm69tgZK+8FM3t9p/EVT59HvEe+85fA/5J+BABwLZIjcMd2RBu8N4MLxxplH2YLY81rGuFCDZt2AA5qDagMG+pLf2XJuvku62VGNJcz6OCQodliu4ZswK+SC1GsYifZ3/WmY6969wU9RlvbUlHagx10HV2g6l4iWfcAF16U0WQt+DJCl8lq5mGy0NkJhmUf13g09Qbm5ZIAYeI180gUvxkbV17acN5pgdRauPS0tItqiQVvaIRUj+sQ8M9/2gfuxBCUGspovcCDp8pwZfR01ylxLA9EeY9MaBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=up7pzzVWdoekUpTbC9vJDhX9Cc0JGdjAaAdDGBcShCE=;
 b=d6HnDJ522hoqdWMgZslf0S1m+V/yEdzOi0g+VDLibmGUwHdVoCKFVXKrTbZNQGndWstqY0/KtyROEY9dFU7+vtIpc6pEnlBvUWEFoA5dD02mwOC9k/uEbBcfcRzGtV0WxonxYMiVXXU4Y6fCT/QXpVGXA9WtkUsNX9+vzm25aGjqFDI2Jf+BAsoMujtF0p4mlvqFBRz3K/1PVCOFuqVo8BUDA+c7Qcmo9zlMAdTJhxinS4x+US9F+u3xbFZDR76LTtwq+LtGxLc1YnNIk3Wvs8FS4ld3cWMnvOjmRc35ctnZOC3XmkgmZrukxJfom2Z3fgL/M7Y6BWG0YNBjl7UkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=up7pzzVWdoekUpTbC9vJDhX9Cc0JGdjAaAdDGBcShCE=;
 b=AXYc3iVpMBmV9QITk2l2aNluYDZhkE3EGfLrV47R2AQbPDx1Imr5uswi3Xc5aNlW1CgWbdF6pCoh90boA49RmqQaTmNCGDxYg4LlTLIf/WowcF/DqboGmb/Bb2NbDycb32Bv0j8ryRMtBEJAsdcKTDSa2m1h5r73R+5KpyDEpK8=
Received: from BLAPR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:36e::15)
 by IA1PR12MB6626.namprd12.prod.outlook.com (2603:10b6:208:3a2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 19:26:55 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::8c) by BLAPR05CA0015.outlook.office365.com
 (2603:10b6:208:36e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.12 via Frontend
 Transport; Thu, 16 May 2024 19:26:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:26:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:26:54 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:26:48 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 00/24] DC Patches May 16, 2024
Date: Thu, 16 May 2024 15:26:23 -0400
Message-ID: <20240516192647.1522729-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|IA1PR12MB6626:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e6350a-2687-4e0b-8821-08dc75de254b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xYg0oC8pI8LguJN4UPkHpp54L1H9dm5nnTC8wWC6SbKyrdkV27VmfcMNBf9X?=
 =?us-ascii?Q?4842nJKqA/VYGQW54jx001S5MExG69O1Tb79QT/d5fUg4d9BmDJjuCIQz28q?=
 =?us-ascii?Q?Roz47FYvtKsu8+vCGpSnc2qMAzjF1Jlbb/lgHMR/FCvxL2GkLJBEAPbWTQN+?=
 =?us-ascii?Q?M+4nNOBPNrsK4zxqFCBnSBRp8X/49kbNth0RSgpyrLmHOuQ+28WxET9lCFB2?=
 =?us-ascii?Q?pUs9f7zK2uZ2KHoxHCnPLRCE2aVfrm9PKkS9c8vwRzoqVbsL3cR9GrCJAoaX?=
 =?us-ascii?Q?jVHpORRMiraM8qQK0W1aJXtF7CG9QQbDuA1yUBD4UBrchoBoDJRnjLfc1MQ1?=
 =?us-ascii?Q?nrg0qYvEu3iUtD/awyzZHbPLeEmZgH0Hfr4SBUR2LSfuQaCrEIHbWLzJoE/C?=
 =?us-ascii?Q?K8lg0hMrTIfWgJbMp2hF11N8oyBuQ4LbYYCFzIwuhe7o5Sf0FtKhfmQ7asaO?=
 =?us-ascii?Q?YIj1Q0g24a4H5UE8zeMeClOrW7z+CDfFMSA7komhWkktNKeA3HSjHaFwog/J?=
 =?us-ascii?Q?soW+XEpIer0CB7P2RNfRM9oulwc75CBpx1sZdWUXwNxYTEU8RK8y46QnC4ch?=
 =?us-ascii?Q?cjJMnA0+L2keQ9DUkUqN72QHDJI2Uhd1xMwmKOhL7cMQ6DGX8VQ3e3nBPGkW?=
 =?us-ascii?Q?75ZQe8mKScrghnu/joVE3qPcRnHOprN4ymAfMRHLwq89NNmBNo//dyXKzc2h?=
 =?us-ascii?Q?TqhkguOurnetLeXraaDXvaxvJLQ/Z93i8Q/Nw2amLEH3DgDBPVVpUhG3Fdqx?=
 =?us-ascii?Q?+2QifMXSlrkHDCGiAskIWSzesZ6sPBQObkwSXiF0KR8F3sLpKQ/nUpcZkYhO?=
 =?us-ascii?Q?RXdFDFVmLL6rto6LM9T1A2jAAGYfWgoQxHlFMash4xHrL5TkuN0zaSgKw+7o?=
 =?us-ascii?Q?6TIz6VE/6alkok4i9Lu614xrN7eOoD7lzzc5RT5AZUZ5o5vMO1jvNcam9wsr?=
 =?us-ascii?Q?HsLG7TgwSCHWbwnhYystPmBHsSpfBBEQPGknTd3gJb1HLq3i8Ni1DJbfCkyo?=
 =?us-ascii?Q?W2jvOwXTgPiD4O/4xuwjvT+7Yce8hJlVzITdbRrYoogjk+F5nzORKZaKk1YG?=
 =?us-ascii?Q?T9PeEcm2qAYu4XRYF9+qh4Dj6FXjQ43G7DyT+6HgyExW0HDY9ZpHtFxCfth5?=
 =?us-ascii?Q?MOU5HC8+Slnrfzr5/8FJtTQhROybtFGtuPI9oix9PBnaZQQvsLS9eIXLt8j8?=
 =?us-ascii?Q?NZaWw0Xdvkbg9RFYKjmnRaf9/7pC9Veg9JNLtmmuIasKX7LeSRs2NUU8xYKd?=
 =?us-ascii?Q?CHzqnkfWw2EGSfm5/wk05118AxDqgJGVX6lJpjddlxPAYlKu/WEv/76ZxQN0?=
 =?us-ascii?Q?Mwm1cIbcs5cOGhJcxwFBWsYcxnXTTAV56X6Nmt+yEzGGVHO2g2GnAW17pScQ?=
 =?us-ascii?Q?QVf28nVVwiz1+mwqytw+6nT12U9I?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:26:54.8195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e6350a-2687-4e0b-8821-08dc75de254b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6626
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

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we have:

    - Fix powerpc compilation
    - Fix TBT+TypeC Daisy-chain lightup
    - Fix underflow on dcn35
    - Fix DVI for dcn401
    - Add 3DLUT DMA load trigger
    - Modify clock programming to support DPM

Cc: Daniel Wheeler <daniel.wheeler@amd.com

Alex Hung (2):
  drm/amd/display: Fix incorrect DCN401 comparison
  drm/amd/display: Adjust incorrect indentations and spaces

Alvin Lee (1):
  drm/amd/display: Fix ODM + underscan case with cursor

Aric Cyr (1):
  drm/amd/display: 3.2.286

Chris Park (2):
  drm/amd/display: Use the correct TMDS function to avoid DVI issues
  drm/amd/display: Deallocate DML 2.1 Memory Allocation

Cruise (1):
  drm/amd/display: Not fallback if link BW is smaller than req BW

Dillon Varone (3):
  drm/amd/display: Modify HPO pixel clock programming to support DPM
  drm/amd/display: Disable DCN401 idle optimizations
  drm/amd/display: Correct display clocks update block sequence

George Shen (1):
  drm/amd/display: Move DSC functions from dc.c to dc_dsc.c

Hersen Wu (1):
  drm/amd/display: Add NULL check within get_target_mpc_factor

Ilya Bakoulin (1):
  drm/amd/display: Add 3DLUT DMA load trigger

Nicholas Susanto (1):
  drm/amd/display: Fix pipe addition logic in calc_blocks_to_ungate
    DCN35

Revalla, Harikrishna (1):
  drm/amd/display: Refactor HUBBUB into component folder for DCN401

Rodrigo Siqueira (2):
  drm/amd/display: Remove duplicate configuration
  drm/amd/display: Add missing DML2 var helpers

Roman Li (4):
  drm/amd/display: Clear shared dmub firmware state on init
  drm/amd/display: Add ips status info to debugfs
  drm/amd/display: Remove redundant idle optimization check
  drm/amd/display: Fix POWERPC_64 compilation

Samson Tam (1):
  drm/amd/display: enable EASF support for DCN40

Wenjing Liu (2):
  drm/amd/display: Add missing enable and disable symclk_se functions
    for dcn401
  drm/amd/display: fix a typo which causes an incorrect ODM combine
    setup

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  47 ++
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   1 -
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 578 ++++++++----------
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 136 +----
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  15 +-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   2 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 159 +++++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |  12 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   3 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  10 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |  12 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c  |   1 -
 .../amd/display/dc/dce/dce_stream_encoder.c   |   1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   1 -
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |   1 -
 .../gpu/drm/amd/display/dc/dcn401/Makefile    |   1 -
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +
 .../amd/display/dc/dml2/display_mode_core.h   |   2 +
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   6 +
 .../amd/display/dc/dml2/dml21/dml21_wrapper.h |   1 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   |   9 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   2 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   6 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   | 207 ++++++-
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |   2 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  96 +++
 .../gpu/drm/amd/display/dc/hubbub/Makefile    |   6 +-
 .../dc/{ => hubbub}/dcn401/dcn401_hubbub.c    |   0
 .../dc/{ => hubbub}/dcn401/dcn401_hubbub.h    |   0
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  34 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 +
 .../dc/link/protocols/link_dp_training.c      |   5 +-
 .../dc/link/protocols/link_dp_training_dpia.c |  16 -
 .../dc/resource/dcn401/dcn401_resource.c      |   2 +
 .../dc/resource/dcn401/dcn401_resource.h      |  54 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  95 ++-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  30 +-
 45 files changed, 1072 insertions(+), 522 deletions(-)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn401/dcn401_hubbub.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => hubbub}/dcn401/dcn401_hubbub.h (100%)

-- 
2.34.1

