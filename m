Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8823CC38145
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 17:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 240D310E7FD;
	Wed,  7 Sep 2022 17:33:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C69DC10E7FD
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 17:33:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObfFcxjz5Kt0vlSiHmK1JWsgc1qf5PTI9soltOm+ihvBT12kL9jD/aOvORURO+DTsRubCGZQyBAQdGAYVW2X8wFF05MelAEg9vi4oqTXigIu5PgjpVYnS4Lo+WZX1r406j0euDCTFRHr0LP33yZ3g3jmwh7mE48TjfU7mnogSTREd97B3ya8aOfl3KHwEBbsBid5ZGX5BJ7xYT4clVsqJZZwHAf4qOtzbFgvwtwPDW/Adnv5vlN6jLOoTRAyzdR5KHwBBmMthgL8i1+CqDMf6zFIkxMDuUpIXDHmeEg/LC6161G1ysW4y1PWjRUgrpRyeHYdQHy+VqLyRnMWepaGbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohcL9tjED/zdCxX4l3qXDN6jiTqGzR/IoESKrtyZoVc=;
 b=QvOawItUMd7LfrF94Of1LyzCjWaXclk5DvhvLpEjbqZIHfyB71UE1qOsZWPpaR/y/Zdzjd56lW3hNksg/hIJ36RQfFG5h2f+l9uJLEZ5uAfNNvGoOZ0637o2e+UEgqpTfzQhwh3Q8/eniY7uHPbBS478sir670VbcOgm7fCu59g+i+a9D98vuy9KOanh9YOiPVdPpAelsnIgcs26IOMEd53Bz6Rcf38EEsq7twkjD3fTcdx4a9zt4SxpnIxa1wpkc+M+/EnmKTaQoGcqCVodIov14WHTf2Z9RWphhThcsJqKd547Lv5yngX0e2AB0iSJzcv9YrkfM64gqDoc29jZSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohcL9tjED/zdCxX4l3qXDN6jiTqGzR/IoESKrtyZoVc=;
 b=Aki0hLKN24crvW/2Xoe6fj1eroc47646lMZb5o1GLw4LAQc9ZAIsxJKNZasV3OmYCFlcUEwuEyCW1YIr44Pj+Vpf2ovtBQgFRiVjqgGA2D3e/RRA6OS4KuMmr/VkgWS4UsBxdym87x0Zry6pBQmaYAumaBaRaCNlrBn3I27Y+Vk=
Received: from BN7PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:20::30)
 by IA1PR12MB6161.namprd12.prod.outlook.com (2603:10b6:208:3eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Wed, 7 Sep
 2022 17:33:09 +0000
Received: from BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::44) by BN7PR02CA0017.outlook.office365.com
 (2603:10b6:408:20::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12 via Frontend
 Transport; Wed, 7 Sep 2022 17:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT116.mail.protection.outlook.com (10.13.176.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 17:33:09 +0000
Received: from promo.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 7 Sep
 2022 12:33:07 -0500
From: Pavle Kotarac <pavle.kotarac@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: DC Patches Sep 7, 2022
Date: Wed, 7 Sep 2022 13:32:05 -0400
Message-ID: <20220907173232.11755-1-pavle.kotarac@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT116:EE_|IA1PR12MB6161:EE_
X-MS-Office365-Filtering-Correlation-Id: 469d5e42-b1a6-4dd1-2fae-08da90f707ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvQK7UX+peV2NKJgQo8FYzlJIk4Zc5vwedzVAih7zvpkPoKx7aYbAz9K4pSWxnokvB2mQYzf/3wrgQtmF3PkRbtEj56iTz6DEE1BVyQLiIPSwLUUrlT24DM9k/nMuMBZ/ubHRILZ7gBQSbTdX6RIqTLB/Uiel73xrHHOeC/dRjMg6w+FfdsxOxY99nElZYJUukwrKfIjwwYVEP3Wcirq4VpdOregugYN09iunfjCGV6C1fT8uggb6EUzyIZsdIF/ufpgY8+Iha0TxUbwWWx41ZtL7+6mcgOYiBYrW5truRooR47q+Krwn2mGhLVEeE7NSRkueQHpaf0DwCpTGBX7l610sZB8Gie/w//jkXbS5PG+PGhe7ZvTezmpDv08vPmBMp8GYsNHne1CnepQJj7fOCFINUkpapdUeCFNOhn/La7OY6qet30Eoaev/CwuzQhjNwJtCKpNoFoGUFPa9xGL1vsWCYedMuDswKYhkb01jKfQsRSnbR0o8DD1AJzXu8BYkvLpQ8Pe/RnjY+b+VnvEwgZEE2RZuGVTZbkkqIp4Wzi+5hS5xVVvUdWJ5tacC4mq3nTRCl+zqpf4o6cGGunjsHWKPPLJoEDVZtMMaVKeAwWLaoyWohVBPzWEGCHCzMO56vlwuOBcZL4SRozJloMb8NCw3RgJlR5BgeJ4eknu4EdFchN9/dwe/nKxdBtG/6kkqDR28eF8yP97pDpjIqCAkLqTuYmjPRSwEeedkJzFOf9V7TrPZ3xDHmCYmLiEf/MxhjhsbvQb2ErAJNIz1Igmd6ixrmGUGSBJKsBJ7Fyk5ZcZJgOiiMKwhgpMAiUHA5bz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(46966006)(40470700004)(36840700001)(6916009)(83380400001)(26005)(40460700003)(7696005)(54906003)(40480700001)(82310400005)(36756003)(8936002)(478600001)(86362001)(44832011)(5660300002)(2906002)(70586007)(356005)(4326008)(8676002)(82740400003)(70206006)(316002)(3480700007)(36860700001)(336012)(81166007)(47076005)(186003)(16526019)(41300700001)(426003)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 17:33:09.0159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 469d5e42-b1a6-4dd1-2fae-08da90f707ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT116.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6161
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

*Fixed register definitions for DCN32/321
*Adding log for spread_spectrum_info
*Reverted DSC programming sequence change
*Correct I2C register offset
*Updated DCN30 header files, viewport position for phantom pipes
*Enable dlg and vba compilation for dcn314


Alvin Lee (1):
  drm/amd/display: Refactor SubVP calculation to remove FPU

Aric Cyr (3):
  drm/amd/display: Optimizations for DML math
  drm/amd/display: Fix divide by zero in DML
  drm/amd/display: 3.2.202

Aurabindo Pillai (3):
  drm/amd/display: Revert "Fallback to SW cursor if SubVP + cursor too
    big"
  drm/amd/display: add workaround for subvp cursor corruption for
    DCN32/321
  drm/amd/display: Fix register definitions for DCN32/321

Chen, Leo (1):
  drm/amd/display: Adding log for spread_spectrum_info

Chris Park (1):
  drm/amd/display: Correct I2C register offset

Cyr, Aric (1):
  drm/amd/display: Don't adjust VRR unnecessarily

Duncan Ma (1):
  drm/amd/display: Correct dram channel width for dcn314

Hansen Dsouza (1):
  drm/amd/display: update header files

JeromeHong (1):
  drm/amd/display: Avoid force minimal transaction in case of
    surface_count equal to 0.

Lee, Alvin (5):
  drm/amd/display: Update MBLK calculation for SubVP
  drm/amd/display: Don't return false if no stream
  drm/amd/display: SW cursor fallback for SubVP
  drm/amd/display: Update viewport position for phantom pipes
  drm/amd/display: Added debug option for forcing subvp num ways

Leo Chen (1):
  drm/amd/display: Fixing DIG FIFO Error

Nagulendran, Iswara (1):
  drm/amd/display: Reverted DSC programming sequence change

Nicholas Kazlauskas (2):
  drm/amd/display: Hook up DCN314 specific dml implementation
  drm/amd/display: Relax swizzle checks for video non-RGB formats on
    DCN314

Rodrigo Siqueira (2):
  drm/amd/display: Fix compilation errors on DCN314
  drm/amd/display: Enable dlg and vba compilation for dcn314

Taimur Hassan (1):
  drm/amd/display: Round cursor width up for MALL allocation

Xu, Jinze (1):
  drm/amd/display: Assign link type before check dsc workaround.

Yao Wang1 (1):
  drm/amd/display: Limit user regamma to a valid value

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  10 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 -
 .../drm/amd/display/dc/bios/bios_parser2.c    |  20 ++
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  16 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  89 ++++---
 .../display/dc/dce110/dce110_hw_sequencer.c   |  13 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   7 +-
 .../drm/amd/display/dc/dcn20/dcn20_mmhubbub.c |   3 +-
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.h |   8 -
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |   3 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c |  24 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  56 ++++-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |   4 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |   1 +
 .../drm/amd/display/dc/dcn32/dcn32_mmhubbub.h |  10 -
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  40 +--
 .../drm/amd/display/dc/dcn32/dcn32_resource.h | 236 ++++++++++++------
 .../display/dc/dcn32/dcn32_resource_helpers.c |  64 ++++-
 .../amd/display/dc/dcn321/dcn321_resource.c   |  37 +--
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
 .../amd/display/dc/dml/calcs/dcn_calc_auto.c  |  22 +-
 .../amd/display/dc/dml/calcs/dcn_calc_math.c  |  16 +-
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |  10 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |   6 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |   8 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |   6 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   5 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  19 +-
 .../dc/dml/dcn32/display_mode_vba_32.c        |  24 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  31 ++-
 .../dml/dcn32/display_mode_vba_util_32.c.rej  |  12 +
 .../drm/amd/display/dc/dml/display_mode_lib.c |  12 +
 .../drm/amd/display/dc/dml/display_mode_lib.h |   1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  10 +-
 .../drm/amd/display/dc/dml/dml_inline_defs.h  |   9 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   5 +
 .../amd/display/modules/color/color_gamma.c   |   4 +
 42 files changed, 559 insertions(+), 310 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c.rej

-- 
2.34.1

