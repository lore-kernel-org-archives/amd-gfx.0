Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8C4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:37:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20CAA10F307;
	Mon,  7 Mar 2022 05:37:51 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B753210F303
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:37:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htPCZ1xMpj0YBPHJ+AUUSWNxvLbHVpiHZhm4Mjvw/0vTTPKdqfM0p3m8bqhj8zUTlgaQjdCev9hqs0dvBFMD8XdseyUKnzWLyMoSeU+SOCKxnj6GyJ7aZl+pMs/9UVikUzt2HDzZHjzr4XSc3xSVxWgIJ39Dlng30Hy9K9b5NWXc05D7L1PaYhrX+iYnDxvFM8jzgvxao3LQ5S+l9KrtfdGgUsRQH4Tsk4IFG5tnudO+eb62kR1onIwtTbSki/7fVwLHZRFga9iars8UXpoKuQ7+fE66iKmJdvEC98lPUCQkbLlrUdCIFUGuIxzUlypB5/x8vkc3/zV0nL4KG0uUUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFpvM79ijvrlpUc5ukAMOTfJ8w9AZDv7gqUZ+ZL5azw=;
 b=hkAhqfJFTxHKdfvja/8auwD6eSwJ3LnCSqvYcUkmhuBfFfUKJD75iGGF5US/LBPcj6T5UX/xIzj1mmxx/2mBWRkLWmRlf0Pafs/jd2ywSTqYWRTISYzL/DWivdZSzqYrExH3X9kGDGsJZHlRmFWEj9ZY2xRWV6YzE/0xKzlZT06cAT0QtPN+/hKLK1bCevmjWKNlIrlGiV2oeJXwMM024EZraa6kxarvASAeaoDXoMOR8XY5mG3i7BYmjaiwS+X03Q1bbYq44aQ8m5OYGcz2GCUsl9EOuRteR5SRlM/S2J8v8YJF3lQF/FZgqDXrq+RNQhRTuWyG7iPDOoCZ29md3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFpvM79ijvrlpUc5ukAMOTfJ8w9AZDv7gqUZ+ZL5azw=;
 b=E6WKfCP09aXIWJ/fCYCy6+uu+EzvExHTCpHnb9UIuHOxDBmoHSwngK9ztV78dcPB37dGGnoN0RjHNElcGD6vlguKEgxqLlSjMRjwOYAq0kx2GKjBwN/C0co1/zQ2ufOUTmjMwna1ebo/Nah55sNfSarw3XIiTkyr9lEFikhpkog=
Received: from BN6PR13CA0033.namprd13.prod.outlook.com (2603:10b6:404:13e::19)
 by MN2PR12MB3342.namprd12.prod.outlook.com (2603:10b6:208:c3::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 05:37:45 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::84) by BN6PR13CA0033.outlook.office365.com
 (2603:10b6:404:13e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.6 via Frontend
 Transport; Mon, 7 Mar 2022 05:37:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:37:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:37:43 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:37:40 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/21] DC Patches Mar 7, 2022
Date: Tue, 8 Mar 2022 04:59:02 +0800
Message-ID: <20220307205923.444306-1-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fa19996-0a03-4f6c-893c-08d9fffc9b38
X-MS-TrafficTypeDiagnostic: MN2PR12MB3342:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB334219A4250AF1D132959784F5089@MN2PR12MB3342.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iTfxe0Hh2qFitV2++D2iSbhksF5zxY3a7Swx4sUxPxaa+1LGsOS3mLOyk0lcnMvDTqqRZZ9LGpR+wBWXKRcXpRXSVV0/gZvl6pGjRArNvJcuokmXudZAVWfIMvr7dBZV879EgeKDJKhYZE5KZKsE9J7z3HcFAgJP3zI+0329cAp6faGqUUf66t0m9GX2h9wdvyfFTmsQTS06CU833M7S5TRArcDeiw7Msl88qIXYjq6NFQGu3H/dojSG0X1jofvA3yFGLI7vh3ri9vsOKVKuHn2Aq7JItF4LNrINnS1wct5HdV3X2tvyVOUUrPRRP0iLw8/VRJ/UTicPlTFH1VFpfU7hJaT90nDXEpMNkNyDsnW7KYEbJfYIskULzJbW4nt2m/JoyBTgsLyw59MPbLoALXLxrgfdMhOzWILgXh03GEaiY9xd3T3wkWcszu8Fp9yY5/z4NByjhnpqnBKOAfN8OkeB5KCEQ92oQw/tdy76gmELI4v8PKFB43M6hdGSyuphogTeARTw12SzDu/gVTYCKPyijUk8QV3SU7+HlxvfeFq15Uig7254mxBM7XWxWPkkNaLxv3Jc06ZNH2f1MBPnaj19xLWDUaNrhWKkfNPTNtRbwdiRzaTEXfRJeGlMecaxTDD1GyBNYFG56+jtEM6Ydul4WuNnnY7Zmil0Xl/zrC+ZCVaAstp2eGrq2RNbiqh+SgpAKLsw39/ZgMz6Yoxqcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(5660300002)(36756003)(70586007)(8936002)(2906002)(81166007)(316002)(336012)(508600001)(426003)(6666004)(7696005)(186003)(26005)(2616005)(1076003)(47076005)(40460700003)(86362001)(82310400004)(83380400001)(8676002)(70206006)(4326008)(54906003)(6916009)(36860700001)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:37:45.0025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa19996-0a03-4f6c-893c-08d9fffc9b38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3342
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:
 
* Remove FPU-related code from dcn20/21/303 to dml folder;
* Fixes related to clock_source_create;
* Several enhancements in DC/DMUB;

    This version brings along following fixes:
    - move FPU operations from dcn21 to dml/dcn20 folder
    - move FPU-related code from dcn20 to dml folder
    - Fix compile error from TO_CLK_MGR_INTERNAL
    - Fix double free during GPU reset on DC streams
    - Add NULL check
    - [FW Promotion] Release 0.0.107.0
    - enable dcn315/316 s0i2 support
    - handle DP2.0 RX with UHBR20 but not UHBR13.5 support
    - disable HPD SW timer for passive dongle type 1 only
    - add gamut coefficient set A and B
    - merge two duplicated clock_source_create
    - Add link dp trace support
    - move FPU associated DCN303 code to DML folder
    - Release AUX engine after failed acquire
    - Add minimal pipe split transition state
    - Clean up fixed VS PHY test w/a function
    - fix the clock source contruct for dcn315
    - cleaning up smu_if to add future flexibility
    - fix deep color ratio
    - add debug option to bypass ssinfo from bios for dcn315

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.107.0

Aric Cyr (1):
  drm/amd/display: 3.2.176

Charlene Liu (3):
  drm/amd/display: fix the clock source contruct for dcn315
  drm/amd/display: merge two duplicated clock_source_create
  drm/amd/display: enable dcn315/316 s0i2 support

Chris Park (1):
  drm/amd/display: Add NULL check

Dhillon, Jasdeep (1):
  drm/amd/display: move FPU associated DCN303 code to DML folder

Dillon Varone (1):
  drm/amd/display: Add minimal pipe split transition state

George Shen (1):
  drm/amd/display: Clean up fixed VS PHY test w/a function

Hansen Dsouza (1):
  drm/amd/display: fix deep color ratio

Jingwen Zhu (1):
  drm/amd/display: add gamut coefficient set A and B

Leo (Hanghong) Ma (1):
  drm/amd/display: Add link dp trace support

Leo Li (1):
  drm/amd/display: Fix compile error from TO_CLK_MGR_INTERNAL

Leung, Martin (1):
  drm/amd/display: cleaning up smu_if to add future flexibility

Melissa Wen (2):
  drm/amd/display: move FPU operations from dcn21 to dml/dcn20 folder
  drm/amd/display: move FPU code from dcn10 to dml/dcn10 folder

Melissa·Wen· (1):
  drm/amd/display: move FPU-related code from dcn20 to dml folder

Nicholas Kazlauskas (1):
  drm/amd/display: Fix double free during GPU reset on DC streams

Sung Joon Kim (1):
  drm/amd/display: disable HPD SW timer for passive dongle type 1 only

Wenjing Liu (1):
  drm/amd/display: handle DP2.0 RX with UHBR20 but not UHBR13.5 support

Wyatt Wood (1):
  drm/amd/display: Release AUX engine after failed acquire

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    9 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   13 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |    9 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h  |   67 +-
 .../dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h  |   74 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    2 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    8 +-
 .../display/dc/clk_mgr/dcn316/dcn316_smu.c    |   26 +
 .../display/dc/clk_mgr/dcn316/dcn316_smu.h    |    2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    9 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    6 +
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |    2 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  128 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    7 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    3 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   36 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |    2 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  117 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |    9 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   62 -
 .../drm/amd/display/dc/dcn10/dcn10_resource.h |    4 +
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   25 -
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 1369 +-----------
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   31 +-
 drivers/gpu/drm/amd/display/dc/dcn21/Makefile |   25 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |  564 +----
 .../drm/amd/display/dc/dcn21/dcn21_resource.h |   11 +
 .../drm/amd/display/dc/dcn30/dcn30_dpp_cm.c   |    2 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |    7 +
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |   26 -
 .../amd/display/dc/dcn303/dcn303_resource.c   |  327 +--
 .../amd/display/dc/dcn303/dcn303_resource.h   |    3 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |    6 +-
 .../amd/display/dc/dcn315/dcn315_resource.c   |   37 +-
 .../amd/display/dc/dcn316/dcn316_resource.c   |   37 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |    4 +
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  |  123 ++
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |   30 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 1922 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |   51 +
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |  362 ++++
 .../amd/display/dc/dml/dcn303/dcn303_fpu.h    |   32 +
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |    5 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    2 +-
 .../drm/amd/display/dc/link/link_dp_trace.c   |  146 ++
 .../drm/amd/display/dc/link/link_dp_trace.h   |   57 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    4 +-
 .../amd/display/include/ddc_service_types.h   |    1 +
 .../display/include/grph_object_ctrl_defs.h   |   22 -
 50 files changed, 3213 insertions(+), 2616 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_smu11_driver_if.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_trace.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/link_dp_trace.h

-- 
2.25.1

