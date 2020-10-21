Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C38AC55179
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00CA322283
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OkgRW3xB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00CA322283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86AE86EDB2;
	Wed, 21 Oct 2020 14:23:02 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00A986EDB2
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUOCAPUN9uStZg9x4BopKk30nvaIptWin3q12A/XZKdr2ZN3IvC0qyCZTYJ3Z/5LShLTfyPrNADyMTR+IPUUkltQUkJ3KHm2zXtqDrlu2h4h05/SJ4TiVFjxocOpigEI81RZDWaF9VkSzXp04AMGt5GykIRj44gBmkfn1J9ZqfPPE+T5DbUvXnFjGlvdoGu1Iq4cbbqaD8aZsmkW1l4Z0l8wVsuqr6RrjAwjsy+URyuoKEMj13LhGEyKq1nhhHzJNf+6DxeYDlIOKIGJg93lt9eJ/cvwJXwzN2YgYcik2mYq/gDipobS5gUJPH7uWaKOnjQSnSjfAk+0qYe26AGQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO/nydv5KESx2mTP9Ded7Q4A9QoY7BuIiaISY6VjT74=;
 b=B1VduMEF95MtG2kwGr2Lxc3hrBk65orziNwLLmN7mhmWPLcIF766K8idEoqkNXmHURuz91/oMeBLQ8ZsuTXQfkyiwgV28TGptX75PO7Wbozuonom0sJ5w8O1oWFESywx0pr3PKDpdfZBTkfuyuRflJzbeM7bgNhw4SnSCZDmcPVwlPhukMJfv8hR878iJZM8VfpKqwY3VxI0pI56MfozTmh8MTE/UxKVSb2nL3Jfhnns4ODYeQj/kMVG+kY3Msf7cdp4fgnzabtdlAPG2R9wWKNp/YRVsMurXjcZe36pXe0pcUdNRgI1nf+Eb15tKlJQiNsSSU6jbOPj25az44s3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO/nydv5KESx2mTP9Ded7Q4A9QoY7BuIiaISY6VjT74=;
 b=OkgRW3xBk3tNI6cYq8OE+YhkdiVxGzI97FFhr+1vomDSpdWDfCpkKR/hTZ+P6tMLiCpNh0RelTMJH6oVSlbzgk/xKOtGHLoFIYpb/jEOP7Yyn9iHhWwde+DYmdv7pVlzjMDOuzMUjfgpHo6mAT8VpiEkxEvc6QDTiLep8/X6r9I=
Received: from DM3PR12CA0051.namprd12.prod.outlook.com (2603:10b6:0:56::19) by
 BL0PR12MB4738.namprd12.prod.outlook.com (2603:10b6:208:8e::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.24; Wed, 21 Oct 2020 14:22:59 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:56:cafe::8c) by DM3PR12CA0051.outlook.office365.com
 (2603:10b6:0:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.24 via Frontend
 Transport; Wed, 21 Oct 2020 14:22:59 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3477.23 via Frontend Transport; Wed, 21 Oct 2020 14:22:59 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:22:58 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:22:57 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/33] DC Patches - 29 October 2020
Date: Wed, 21 Oct 2020 10:22:24 -0400
Message-ID: <20201021142257.190969-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddde48d9-ed50-4cff-dd96-08d875cccfbd
X-MS-TrafficTypeDiagnostic: BL0PR12MB4738:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47380CFE29EC00E56DF5529E8B1C0@BL0PR12MB4738.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KHyRRGc9wAMSY5r7JC97BT+vMwvGsTG5YnKCOBWkV5ujM1LGoDOG0ShzlghqNFii5u515u+Z6jvULWoTUA3fbxjFgXZrxyq5NTPunV20Qt9tGc4OhT4qqaye9HevYFuYAr68sI85Wz+uMZs7cTXlVhXWh4NCvFitkhl8bA3WHC1cN+hywMiwqujyICNh2CJFnHN9IlM5etp95c+9gBq+hULauW5xp3RM9V5eAkwpR4cIQP9ON0E8fo2txjfEIjglEnlfmzHCYEZ3qNDnP+XAaGYF23yZPAheIgUA3UHDdj9l8bFDJIF7nHSGj+EEF+x0CyYyEzv81am3Yg4SK2ZVcynZYsfkGCiMLEVkPZzz7MHkBcGZqV3Xqab61HadCoAzwD8DLlBH2AcLBG4RJNkSVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(46966005)(8676002)(5660300002)(2616005)(44832011)(7696005)(4326008)(2906002)(6916009)(316002)(81166007)(1076003)(36756003)(336012)(356005)(54906003)(82310400003)(8936002)(83380400001)(70206006)(186003)(426003)(6666004)(86362001)(26005)(70586007)(82740400003)(47076004)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:22:59.1020 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddde48d9-ed50-4cff-dd96-08d875cccfbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4738
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
 
* DC version 3.2.108
* Firmware release 0.0.38
* Tracing additions
* Improvements & fixes across ODM, DSC, watermarks and others.

--

Alvin Lee (2):
  drm/amd/display: Set WM set A to 0 if full pstate not supported
  drm/amd/display: Update GSL state if leaving immediate flip

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.37
  drm/amd/display: [FW Promotion] Release 0.0.38

Aric Cyr (3):
  drm/amd/display: 3.2.107
  drm/amd/display: Don't trigger flip twice when ODM combine in use
  drm/amd/display: 3.2.108

Ashley Thomas (1):
  drm/amd/display: Source minimum HBlank support

Brandon Syu (1):
  drm/amd/display: skip avmute action

Clark (1):
  drm/amd/display: Fix max brightness pixel accuracy

Derek Lai (1):
  drm/amd/display: combined user regamma and OS GAMMA_CS_TFM_1D

Dmytro Laktyushkin (3):
  drm/amd/display: add dcn21 bw validation
  drm/amd/display: enable odm + full screen mpo on dcn21
  drm/amd/display: prevent null pointer access

Eryk Brol (1):
  drm/amd/display: Reverting "Add connector to the state if DSC debugfs
    is set"

George Shen (1):
  drm/amd/display: Removed unreferenced variables.

Isabel Zhang (1):
  drm/amd/display: Revert check for flip pending before locking pipes

Martin Leung (2):
  drm/amd/display: adding reading OEM init_data to dcn3
  drm/amd/display: adding ddc_gpio_vga_reg_list to ddc reg def'ns

Nikola Cornij (1):
  drm/amd/display: Add an option to limit max DSC target bpp per sink

Reza Amini (1):
  drm/amd/display: Define PSR ERROR Status bit VSC_SDP

Rodrigo Siqueira (5):
  drm/amd/display: Decouple amdgpu_dm_trace from service
  drm/amd/display: Rework registers tracepoint
  drm/amd/display: Add tracepoint for amdgpu_dm
  drm/amd/display: Add pipe_state tracepoint
  drm/amd/display: Add tracepoint for capturing clocks state

Roman Li (1):
  drm/amd/display: Refactor ABM_MASK_SH_LIST_DCN301 naming

Sung Lee (2):
  drm/amd/display: Add Bounding Box State for Low DF PState but High
    Voltage State
  drm/amd/display: DCN2.1 Disable 48MHz Powerdown Debug Option

Taimur Hassan (1):
  drm/amd/display: Raise DPG height during timing synchronization

Yongqiang Sun (1):
  drm/amd/display: Reduce height of visual confirm on right side.

Yu-Ting Shen (1):
  drm/amd/display: disable seamless boot for VSC_SDP

jinlong zhang (1):
  drm/amd/display: Using udelay for specific dongle while edid return
    defer

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  97 +--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   | 565 +++++++++++++++++-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  30 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |   2 +
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |   5 +-
 .../gpu/drm/amd/display/dc/core/dc_link_ddc.c |   7 +
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  39 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   8 +
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c |   1 -
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  10 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |  26 -
 drivers/gpu/drm/amd/display/dc/dc_trace.h     |  39 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   4 +-
 .../amd/display/dc/dce100/dce100_resource.c   |   1 +
 .../amd/display/dc/dce110/dce110_resource.c   |   1 +
 .../amd/display/dc/dce112/dce112_resource.c   |   1 +
 .../amd/display/dc/dce120/dce120_resource.c   |   1 +
 .../drm/amd/display/dc/dce80/dce80_resource.c |   3 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 157 +----
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   1 +
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  |  12 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |   4 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  17 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.h |   3 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 -
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 206 ++++++-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 -
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  48 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  42 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  24 +-
 .../display/dc/gpio/dcn30/hw_factory_dcn30.c  |  12 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   2 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   5 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  27 +-
 .../amd/display/include/ddc_service_types.h   |   2 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |   1 +
 .../amd/display/modules/color/color_gamma.c   | 122 +++-
 .../amd/display/modules/color/color_gamma.h   |   6 +-
 52 files changed, 1206 insertions(+), 376 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_trace.h

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
