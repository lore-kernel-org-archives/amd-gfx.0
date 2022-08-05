Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EF4C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 16:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5C5B868B;
	Fri,  5 Aug 2022 16:45:01 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B50B8682
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 16:44:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZUSP9neiHG0iQ1F1+EHtvBIBlPpShvYC/UAP4zTrnfAvIa3qVXaiP89JorWOQc8i7mcxG9yhhkxO1UQ7y8ynFlbcaQLKh4dDiJPVW20HeXIDa3fImFfSwuzkkJIxNZfo3BEGKEBxdmm5Tjp9BmSjWOZT2r/pd4v4QczjEyqJeXD1v8yn7h1v1pe9QE/N40VX8DciRwwemtRWyT+0RFy/zVw2r7myTiJfC9n6Vw9+Vc/b2/sephXAKJ+szqpj5Uca2X9u0sZSV5gnwkSXmGKuWbJ/sRCpkE1ZjXmQEJf13c+rNBjSlc4ue/a8hpiqL6a0xZA4uhQjVPiKkVLhWD6iXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWLMVOP9E5MYe9DxIcFscwUOm+eVIIrxod0OdXsII6s=;
 b=LBuV01jMM/0ksndx24pvqKe2O8EYTU5V7o/utVB//NXfp3Eyud7DuZHiMyDZXW4yOmL6pvtIeVNVOPb8NgouYZ9gBv6UA6siQKwBrz5pZ2ZZ6M+4KVX6WmeiB9Byms1euES0xHHHfBL3ETevSng+NYKdZo3FdFIywJYah0VguR9HcN3gkzJzCbA7Xs6prKfk4vnwkJSBu5VuqyRawtEfMBazuLJmCW024Dl1zpLy5OmNVJN8Zbjq0ozJrHSIAnYvb6LYW3M0YezUlmMWzRqf8k5lcAdA0jq6bZoE2GofuTvoHRhCwxd3YOKHkdkrTCzbtVrml1pYm5f9WqEVxi1XWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWLMVOP9E5MYe9DxIcFscwUOm+eVIIrxod0OdXsII6s=;
 b=DJ0rgj1v+a4pR1f4sNrgkIVjyQ42C3nfXNobRXJBnrgwCuSpD+aOUhvye2Ib1vx9qsovS0QTGkovzKTrSmhhO4QC8fB3kT0qgl2/mPoa/EUW8z2GOdRKRwEB6U60RS5bW0hoLakCzrmdv6/J0pRAoqsKZyVUe8MRyz1dogFOVGw=
Received: from BN9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::31)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 16:44:41 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::f8) by BN9P221CA0011.outlook.office365.com
 (2603:10b6:408:10a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16 via Frontend
 Transport; Fri, 5 Aug 2022 16:44:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 16:44:41 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:44:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 11:44:38 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 11:44:33 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/32] DC Patches July 29 2022
Date: Sat, 6 Aug 2022 00:42:57 +0800
Message-ID: <20220805164329.2988533-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 89114f72-8a5a-4ca3-9141-08da7701cb2f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5175:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qm6deaY4UnHVzsMDJxvzp8Yfz4zNSVXivhrf0HTpI6HF2KoV5l17Dv/yNQHSVvlKkFzB2JSLKKK5ZxRBMfCT407emXOLfUdnw4oKEKdM/eYEaHqMjM8wkK8nieNhPDN/JEkvgmfz1ns3NGddLGWwhHfZSGiv6pBrzrqHfQ+hmLokdGY6oMG9rocjwBPp8bEorsxxInEn5nMFJIYpgT9G6wrm/JKCweCmbdQgTQ+AamwN8KQydiV3Rr4Q8smvpiWpCQVvu+lymQrGVN1dU9mCAzSqGP35oJlZqYuM3EVGWuExTUDaVDmn49VMW2ZEZU4AvH77+zhcAlh/dERFDwBD3NMht74OYY82n2dx1ZRA4di4dgUSuY9cxec2gXDZj30nHZfVdKb8i0aD4aWw0BswceL7JCXsW5QwVUXSbVFQeSQtMAPLlyaVAie8cHcFEvVY63w9F4tk3vtnyy5CVnLyqEheViImZ5s7yeeX7BAhVcviBuVTGeYUATCCQl6SWRx/98LrMIHPaZhczZ6PKtBAv/vwbhjkqJOz+V/+TS9ZDpD6asHS/mM6YryCpe5vEEpAMzlmZdg7Oh/9b+9+4mnhzmJ3ocnf2V+z0N8oDglczkiTBu0qp79eZDXsMkOq9bR1N5nNTMir584Q2c9cr8ENKXenr4pVIAgi+GAYQTZsxKXEVGAgO8zB8sLzN3O3CPUm0hSCpQHTrv3VgMaYOy5ezQxxWo8cPxGqh3zzN2DCcCuS2jpFsW6aiOuNmRYC1+idA6XL1EUtDYFQVaMHrT2vJAmfZaGoayj1LPtKp63t0YSlARbr32DhXR/r73npWVBZ9bU5hWYBV+kbPsP8lAS53Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(40470700004)(36840700001)(46966006)(2906002)(6666004)(2616005)(83380400001)(70586007)(70206006)(36860700001)(316002)(47076005)(41300700001)(5660300002)(336012)(426003)(478600001)(40460700003)(6916009)(1076003)(54906003)(186003)(40480700001)(26005)(36756003)(356005)(82740400003)(82310400005)(81166007)(8936002)(86362001)(7696005)(4326008)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 16:44:41.3286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89114f72-8a5a-4ca3-9141-08da7701cb2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings along following fixes:

- Move fpu file to dml folder
- Fix CAB allocation for multiple displays
- Add a variable to update FCLK
- Fix TMDS 4K@60Hz YCbCr420 corruption issue
- Fix MPC tree infinite loop in some case
- Fix SubVP calculations
- Fix HDMI VSIF V3 blank screen issue
- Add some documentation to the code
- Allow alternate prefetch modes in DML for DCN32
- Fix VPG instancing for dcn314 HPO
- Check correct bounds for stream encoder instances for DCN303
- Enable SubVP by default on DCN32 & DCN321
- Fix DTBCLK not correct for dcn314
- Fix Compile-time warning
- Fix the stereo mode hang issue
- Fix display light up issue

Aric Cyr (1):
  drm/amd/display: 3.2.197

Aurabindo Pillai (3):
  drm/amd/display: fix CAB allocation for multiple displays
  drm/amd/display: Check correct bounds for stream encoder instances for
    DCN303
  drm/amd/display: Enable SubVP by default on DCN32 & DCN321

Daniel Miess (2):
  drm/amd/display: Use pixels per container logic for DCN314 DCCG
    dividers
  drm/amd/display: Fix TMDS 4K@60Hz YCbCr420 corruption issue

David Galiffi (2):
  drm/amd/display: Allow alternate prefetch modes in DML for DCN32
  drm/amd/display: Fix Compile-time Warning

Duncan Ma (2):
  drm/amd/display: Fix VPG instancing for dcn314 HPO
  drm/amd/display: Correct DTBCLK for dcn314

Huang, ChiaWen (1):
  drm/amd/display: Device flash garbage before get in OS

Josip Pavic (1):
  drm/amd/display: Avoid MPC infinite loop

Lee, Alvin (8):
  drm/amd/display: Revert "fix 32 bit compilation errors in
    dc_dmub_srv.c"
  drm/amd/display: Add a variable to update FCLK latency
  drm/amd/display: Refactor SubVP calculation to remove FPU
  drm/amd/display: Add 16 lines margin for SubVP
  drm/amd/display: Fix subvp calculations
  drm/amd/display: Revert "attempt to fix the logic in
    commit_planes_for_stream()"
  drm/amd/display: For stereo keep "FLIP_ANY_FRAME"
  drm/amd/display: Don't try to enter MALL SS if stereo3d

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix HDMI VSIF V3 incorrect issue

Meenakshikumar Somasundaram (1):
  drm/amd/display: Fix TDR eDP and USB4 display light up issue

Rodrigo Siqueira (9):
  drm/amd/display: Create FPU files for DCN314
  drm/amd/display: Move populate dml pipes from DCN314 to dml
  drm/amd/display: Drop FPU flags from Makefile
  drm/amd/display: Add documentation to some of the cursor struct
  drm/amd/display: Add basic kernel doc to CRC code under DC
  drm/amd/display: Add some extra kernel doc to amdgpu_dm
  drm/amd/display: Document pipe split policy
  drm/amd/display: Expand documentation for timing
  drm/amd/display: Document some of the DML structs

Wang, Fudong (1):
  drm/amd/display: clear optc underflow before turn off odm clock

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  16 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  46 ++-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  12 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  45 ++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  40 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  93 +++--
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  | 148 ++++++-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   1 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c |  44 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   6 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.c |   2 +-
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |  25 --
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.c  |  42 +-
 .../drm/amd/display/dc/dcn314/dcn314_hwseq.h  |   4 +
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |   2 +
 .../amd/display/dc/dcn314/dcn314_resource.c   | 341 +---------------
 .../amd/display/dc/dcn314/dcn314_resource.h   |   3 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  39 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   3 +-
 .../amd/display/dc/dcn321/dcn321_resource.c   |   3 +-
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 376 ++++++++++++++++++
 .../amd/display/dc/dml/dcn314/dcn314_fpu.h    |  40 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  46 ++-
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    |   7 +
 .../amd/display/dc/dml/display_mode_structs.h |  34 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  14 +-
 .../amd/display/modules/freesync/freesync.c   |  15 +-
 34 files changed, 968 insertions(+), 498 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h

-- 
2.25.1

