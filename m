Return-Path: <SRS0=2XV/=OH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C774C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:25:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1527604E9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Sep 2021 19:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1527604E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6266EE76;
	Fri, 17 Sep 2021 19:25:50 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2088.outbound.protection.outlook.com [40.107.96.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEBF06EE76
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Sep 2021 19:25:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=im/dOXPEe039dOPAPl5gP/9Uzil2z576K4AlnZDEh3IAHOJ2KEhQmSoW4ynVt4kSqPDRXjHii4d8fYaiorlYFJrMwVG3Xt7BJxSa7GE87CJKMgeE4c/VDwS7Q+OWeZjQplo1N0lrAFx9fEQAVaB6KSLeK41/PPH0GhIyjxRYLlDIGK6ZMZK2FQMXNAdszTkfs9H5tGOD5tSGV1T/pN07NtLdt61dBsFfuZtlAEaUyUOOhDutHF7YLbSs3WCqasymLRgqdmdo1RLP6rbLngJLeeIosjjANi1fiC+IgbwTCNDfJRrCmve87rh3WajZmIGgQaIP7td/LFSGqgV014pNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=wsry4ErvT4VZp9GrO4IJKWCLxFabFL/tohDlDl+kFUw=;
 b=IpdJAYbOcoASKm4qnYfuDnOqub7DPx6PBbWHIMZqzWilqbqoishibxd8Cw5jV0pCu6dNnDwUkPem042CpbPCkX6u5hiJdg0+raGHThdkQ7PcbmxMpdV2LU6wTnKA1T9BFOqaVqjW07oXo4r4Xz0f7Euqmi709dJshQzpQnOBuSP9mQXV0kz5hwRYkKMqZmzwRaQNVfCE+hQsPdzYxMxlgZo44q2KUDLjEkdhZrZ1eSDmrzRvN2YyBFw2/VKLBuMMietmayLWxYYVsFeg1JN9JJzlZ/a6Qna24+SgnSjPukDBrLw9LeAwXBPpLqZ2fMYAnAeH/M5pZNzH44u506aVWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsry4ErvT4VZp9GrO4IJKWCLxFabFL/tohDlDl+kFUw=;
 b=h3U6xrrAGQpgDXvjazIOxv2CyY9OxDsG62uMDLbr/WeUUYCV59geJmYrH4CUOhqOQPD4UGyCypPsl0P6B7wJo4/6QDFBpnNx5D2JlyWSCX6oCIlS1/vvLCnbg8BHZyCntwPnSkg4zI7+zOEjI7eocnK8E4m7+87Y0Cvt5hQM+34=
Received: from BN9PR03CA0517.namprd03.prod.outlook.com (2603:10b6:408:131::12)
 by DM5PR12MB2440.namprd12.prod.outlook.com (2603:10b6:4:b6::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 19:25:46 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::20) by BN9PR03CA0517.outlook.office365.com
 (2603:10b6:408:131::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16 via Frontend
 Transport; Fri, 17 Sep 2021 19:25:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 19:25:45 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 17 Sep
 2021 14:25:44 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Mark Broadworth <mark.broadworth@amd.com>
Subject: [PATCH 00/18] DC Patches September 17, 2021
Date: Fri, 17 Sep 2021 15:25:06 -0400
Message-ID: <20210917192524.3020276-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac1af809-1754-4b92-218e-08d97a10f2b5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24401893A38BDD7DAA013D5A98DD9@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qc7Lr+sRgaXjBw8Begs6PQng63tIAkcpxpH1w/75OmZoeNlWL+wtmaVV53ddwTXa5qD+kIST2DLDeN4fzWpKoCN8+72OlVDZz7vl3/J/NWorT10fRQ4UoVGtNt71XfVV51LiLF5v1Lds514+vgt3FoA8ihT1h0UUzQDHOE65v1jh/7WZDH7uZiMwp19yB16RZ03Bwnbvp6cFipI5RdAvjGnwzoXKoOuqCxPwy81gbgW7nlbJJPgZMyPcm43zqUWDe4otN5lGPna8etaTElXRY1MRMlhbekSQIgef1X9M+ARKQhhDlEOUZDw2EX3AX9nUJfL/nTJM2p2QjNuPZxTkv0xUtCM/bbbTes6hrV3NbE00ulhPSVfqMmuL3Spbd5L/BzHBHC+wj4e4+NuSDxJEoCGXGA65oAsEArQez100L7NxbGcEOndFX+kjmEc5/yFA9AtJqaHC93fuonQT5JYLHZgTNc+vQsluIMD11VD4AmWct1r4hHjxWREaXqeNkwUIP6FMKvf3Odts7zCsBSDn2AFCGa3ZwR+xyKwS33KOBY+RQAZ9FYHnm4n8ALa2MtMDPyPutu87QkSabLOe4TiytHtp+ky0wiZnr2/b/f14RCtsYxadBQC/FmacdU7FxBHbxPawAcJoYy83sb2gecb3WvTZtZ3Cuno1QiDQfHTMEz2jiGPg4UbNXrkc52Qv3H3Vz73XxIW5+FsK8HsKoAaGGrG7ufvcMB0ScsHyfqi6Wto=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36840700001)(46966006)(478600001)(6666004)(81166007)(1076003)(8936002)(426003)(8676002)(47076005)(2906002)(356005)(36860700001)(82310400003)(86362001)(26005)(4326008)(70586007)(70206006)(16526019)(54906003)(2616005)(6916009)(82740400003)(186003)(336012)(5660300002)(316002)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 19:25:45.9218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1af809-1754-4b92-218e-08d97a10f2b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- New firmware version
- Fix HPD problems on DCN2
- Fix generic encoder problems and null deferences
- Adjust DCN301 watermark
- Rework dynamic bpp for DCN3x
- Improve link training fallback logic

Best Regards
Siqueira

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
Cc: Mark Broadworth <mark.broadworth@amd.com>

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.83
  drm/amd/display: [FW Promotion] Release 0.0.84

Aric Cyr (2):
  drm/amd/display: 3.2.153
  drm/amd/display: 3.2.154

Guo, Bing (1):
  drm/amd/display: Fix issue with dynamic bpp change for DCN3x

Hayden Goodfellow (1):
  drm/amd/display: Fix wrong format specifier in amdgpu_dm.c

Jimmy Kizito (4):
  drm/amd/display: Fix link training fallback logic
  drm/amd/display: Fix concurrent dynamic encoder assignment
  drm/amd/display: Fix dynamic encoder reassignment
  drm/amd/display: Fix null pointer dereference for encoders

Lai, Derek (1):
  drm/amd/display: Added power down on boot for DCN3

Liu, Zhan (3):
  drm/amd/display: Fix DCN3 B0 DP Alt Mapping
  drm/amd/display: Fix B0 USB-C DP Alt mode
  drm/amd/display: DIG mapping change is causing a blocker

Meenakshikumar Somasundaram (1):
  drm/amd/display: Creating a fw boot options bit for an upcoming
    feature

Michael Strauss (1):
  drm/amd/display: Disable mem low power for CM HW block on DCN3.1

Nikola Cornij (1):
  drm/amd/display: Use adjusted DCN301 watermarks

Qingqing Zhuo (1):
  drm/amd/display: Extend w/a for hard hang on HPD to dcn20

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  12 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  17 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  39 +-
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c | 461 ++++++++++++++----
 .../drm/amd/display/dc/core/dc_link_hwss.c    |  35 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  17 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_link_encoder.h |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   5 +-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |   3 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |  18 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  17 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.c  | 198 +++++---
 .../gpu/drm/amd/display/dc/dcn30/dcn30_vpg.h  |   6 +-
 .../amd/display/dc/dcn301/dcn301_resource.c   |  96 +++-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |  39 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |  11 +-
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |  15 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |   4 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |   2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  18 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   2 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   6 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |   6 +-
 .../gpu/drm/amd/display/dc/inc/link_enc_cfg.h |  23 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |  25 +
 .../display/dc/irq/dcn20/irq_service_dcn20.h  |   2 +
 .../dc/virtual/virtual_stream_encoder.c       |   3 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   7 +-
 .../include/asic_reg/dpcs/dpcs_4_2_0_offset.h |  27 +
 36 files changed, 878 insertions(+), 255 deletions(-)

-- 
2.25.1

