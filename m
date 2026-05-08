Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10042CD342F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 18:28:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9992210F5AF;
	Fri,  8 May 2026 18:28:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AYCvvM8/";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012051.outbound.protection.outlook.com [52.101.43.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEFF10F5B4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 18:28:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8P+QOCtmn+bY3wnFIh1CFCgDZ+eyAcY/KXK19JsbPsSl2DizH7IlC+RYfcszLnMLd7fBuXAu8KSGHSGD7hWps/ZFBY6Q3ET7fKACZ8JZCJaKshq+DM4rqxgxVI1MqPOF+ZNTf8i2uAjDveMMbXhlyTQfyXVMNsi58BMazd7Tm7vwmKnlA4AZuzvgwyb0zs9rcjvQj7sS+JHJN2IPDYbwHRqF9cUPwaZN+F72KSsTKmPVwrJEM2Hh+s14I16l6qfXDbupbmY1uiOqADnIuT3VYSUfeU1/9+SCkOfslrHDe8GWagI7bENBYeFo4GaeCgZvlmHVO/zUjGQAvK4Smwvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HIMOMZoN5/Lp5josTdgavImROtkykgAJd6hmuxJOtU=;
 b=W6pigWVXWYIVHIodQNe1obcmEWZjHMC5w7OhzNhHneDGmZN3xrkhP2GkreWuo2SBCYNPjwbMz8wZTJiyyiTnJ4+RT+dUOWUNBSPzJ9rcgXvI9Wa0ENpp6lObHOil0FY09G//wYCoiSifNhtOR3eLkISmjPUcc+U63S6VQaiufrMShX3W83PP6nDf1bqu9/A77FAmxcy1J7ZZ4ET6h7NOXE/DZY2ZsCfYNsZtjyqtqUvyPXCiH3oWmmmZup2RZSmMQ+m3m8HO6UEU/1oZ3Vu4SkvU85My86RPDd3ForixKbQg8zLIGJPJiyFTPiceUo9Y5n5YdZHbm7K1d9YacG3wSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HIMOMZoN5/Lp5josTdgavImROtkykgAJd6hmuxJOtU=;
 b=AYCvvM8/BszP4yaO3BdZhVLUvgxNyKVXc0H411r5e9nRjSkadG5Rzl2wvZdzQCqhDsf1MIXUp3Fq+fDnaXObt/fsV+tJ0mCKfyFKEJADAHcMelY0uJrQ9fxYmlo/84G6jVU8Xzyp6YMRUqM4GHWaAE3LU6XS1pnEnfntw6gJHXc=
Received: from MN2PR03CA0015.namprd03.prod.outlook.com (2603:10b6:208:23a::20)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.18; Fri, 8 May
 2026 18:28:18 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::ef) by MN2PR03CA0015.outlook.office365.com
 (2603:10b6:208:23a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.20 via Frontend Transport; Fri,
 8 May 2026 18:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Fri, 8 May 2026 18:28:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 8 May
 2026 13:28:12 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 8 May 2026 13:28:11 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Rodrigo Siqueira
 <siqueira@igalia.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>,
 =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Subject: [PATCH v3 00/14] HDMI FRL and DSC Support for amdgpu
Date: Fri, 8 May 2026 14:27:52 -0400
Message-ID: <20260508182808.520863-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: bc006166-b215-4e82-6079-08dead2f9351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: KH6o0PnH0FN9Wp1MCY41/3g5yE9dXZtUY/sMxFGbkXXHOIWHjsl6eSafnpKCQDGPr7nT47FQRXro0VvOVx20yzHaoplxIH4Jdxa2jm0g+ZRuelpyLoFYBnIg+p0Q3iG1uUw1OiAsCMa+M0MRL+XEf6zArNwzQbm7RlHwB+q5YBFd9bTTvwylmj3WE1oHCblp5ALS0c8ZVkETtB7dOmDugBCDwDrRStHT0KlS1VmfQd74nAS8/Z7AwBXNkuSRQbJ7FAIK4C0ET6VQJFnN1leEHeGkZ4OXn3rfzPVKxuF8Bm44yodcJnE9I5O4bkdJYnx+y0JV8gOO3R716FXUXurjrec9ZS8QdODuPFp0ls5+FSYLrCLVXQ8PZYKag4igBd1F+ApcwTqRWByyLvCS0kDBawr+nNvBKGzV7CPYTf/w9ITCo9O8hVNfj6Glk82gcIZpiLlMAKAOIssAfsIVXHdzOukB6SI1pk5vIN2GeeHcs4DZRhixsh7nlZvo3KNXhUW8ZKyzOBx0RYUFzBk5Dl/r7cDmeIxNNWKOyBuYi5FL6hs3fokhmrr35PfWfyng0k4dmB6FD0XrwKY2bap1/mx9mOgN8Lc6EtBVprjm+jph4MZr5pk6tWmFnyxnB2/IK56h6adDoiKq+OQtOA7TtS3MzYroHcA6y/ZFu3Fg7ej4VKH0XzRZdp2RcqRqNodN+vzVRvA/OasYbXCce3RwkB8CW+WdX5tWsnoLmcyiPuSKdAo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y8K9Jpkpzg5pWB7IPGVG+ciE+MLGMIUh+wF+7VV/M/fW2rLdLagkCQl0pvxSYM9fo7B8JFxcd9Zjs0NHm5YaDNl5YpCCwYsDyBELgwR/aIo8qdy+9pvJDD40SY1vXXSw/e0ZpMuEpTAcVXX2deBEIXAIsAIOYAM/6ZGr8NEeY/5PPbZEVKJPsu8lQH+wh7EpL/A95cx+evHkaoIDm89SZxq/mnX4dd8G9sh736fVeXAqoSRMaJ0mD8Fk6qswSzF2wP7PA4cEOWizqGBIaUvUScvafGyfxwBl92N1uzS/blAAHzhnyF4Py8oh8MicpW12jWdCnXh2OJTqrdwLBU02BMn++OdsobVtRcBKgIzatpPMgUcLSINDGzfCxCSUrvMP5JhLEr3xSQMGzA7bKMoA8m4k2x0mdmWz/ECGK5Iwhf0ElleFYFuWHfurSuJRfQf7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 18:28:17.9413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc006166-b215-4e82-6079-08dead2f9351
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037
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

This patch series adds HDMI FRL and FRL DSC support to the amdgpu
display driver.

This work passed a representative subset of HDMI compliance and a full
compliance run on this branch is in the works. We don't expect the full
run to show any failures since it passes in other environments.

Thanks to Siqueira who prepared this work a couple years back and
unfortunately didn't manage to send them while he was still working
at AMD.

Thanks to Jerry who has been making this code solid on Linux and
running the compliance tests.

The first patch in the series isn't related to HDMI 2.1 but included
here because it moved the code around some key bits of the HDMI 2.1
stuff around too much. It will land with the next DC Patch series.

v3:
- Add missing DML2 bits
- Merged register headers to asdn and removed from patchset

v2:
- Add missing function pointers on DCN 3.x
- Add DSC

Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Zuo, Jerry <Jerry.Zuo@amd.com>
Cc: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

Fangzhi Zuo (1):
  drm/amd/display: add HDMI 2.1 Compliance Support

Harry Wentland (13):
  drm/amd/display: Add HDMI FRL definitions to includes
  drm/amd/display: Add DML changes to support HDMI FRL
  drm/amd/display: add HDMI 2.1 FRL base support to DML 2.0
  drm/amd/display: Add DCCG DIO, HPO, OPP, and OPTC support for FRL
  drm/amd/display: Add FRL support to clk_mgr, dsc, hdcp
  drm/amd/display: Tie FRL programming together in HWSS
  drm/amd/display: Add DC resource support for FRL
  drm/amd/display Add DC link support for FRL
  drm/amd/display: Add support for FRL to DC core
  drm/amd/display: Update HDCP and info_packet modules for FRL
  drm/amd/display: Tie FRL support into amdgpu_dm
  drm/amd/display: add HDMI 2.1 DSC over FRL support
  fixup! drm/amd/display: add HDMI 2.1 DSC over FRL support

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  160 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   11 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   28 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    2 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  114 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   91 ++
 .../drm/amd/display/dc/bios/bios_parser2.c    |   21 +
 .../drm/amd/display/dc/bios/command_table2.c  |    6 +
 .../dce112/command_table_helper2_dce112.c     |    3 +
 .../bios/dce112/command_table_helper_dce112.c |    3 +
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |    3 +
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |    3 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |    3 +
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |    3 +
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   12 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   14 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   32 +-
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |    4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   49 +
 .../drm/amd/display/dc/core/dc_link_enc_cfg.c |    3 +
 .../drm/amd/display/dc/core/dc_link_exports.c |   45 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  287 ++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   35 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  128 ++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    8 +
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |  164 ++-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    8 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   24 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.c    |   40 +
 .../amd/display/dc/dccg/dcn30/dcn30_dccg.h    |    8 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |   88 ++
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   13 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   25 +
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |   68 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  321 +++++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   73 +
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.h  |    4 +
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   33 +
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |    8 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |   30 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |    3 +-
 .../display/dc/dio/dcn20/dcn20_link_encoder.h |    1 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |  250 ++++
 .../dc/dio/dcn30/dcn30_dio_link_encoder.h     |   17 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |   18 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |  114 ++
 .../dc/dio/dcn31/dcn31_dio_link_encoder.h     |    8 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |  214 +++
 .../dc/dio/dcn32/dcn32_dio_link_encoder.h     |   16 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |   20 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |   21 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |  220 +++
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |   16 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   21 +
 drivers/gpu/drm/amd/display/dc/dm_cp_psp.h    |    1 +
 .../drm/amd/display/dc/dm_services_types.h    |    1 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |    3 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    5 +
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  127 ++
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |   22 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |  280 +++-
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    |    1 +
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    |    1 +
 .../dc/dml/dcn31/display_mode_vba_31.c        |  243 ++++
 .../dc/dml/dcn314/display_mode_vba_314.c      |  241 ++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   10 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |    2 +
 .../dc/dml/dcn32/display_mode_vba_32.c        |   16 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |  127 +-
 .../amd/display/dc/dml/display_mode_enums.h   |    1 +
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.c |  786 +++++++++++
 .../drm/amd/display/dc/dml/dml1_frl_cap_chk.h |  173 +++
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |    2 +
 .../amd/display/dc/dml2_0/display_mode_core.c |  104 +-
 .../amd/display/dc/dml2_0/display_mode_util.c |    3 +
 .../dml2_0/dml21/dml21_translation_helper.c   |    4 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |    1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   29 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    3 +
 .../lib_frl_cap_check.c                       |  396 ++++++
 .../lib_frl_cap_check.h                       |   90 ++
 .../dc/dml2_0/dml2_translation_helper.c       |    4 +
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |    2 +
 .../amd/display/dc/dml2_0/dml_frl_cap_chk.c   |  413 ++++++
 .../amd/display/dc/dml2_0/dml_frl_cap_chk.h   |  109 ++
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  704 ++++++++++
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |    5 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |    1 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |   10 +
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c |  286 ++++
 .../dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h |  146 ++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  | 1043 +++++++++++++++
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.h  |  436 ++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.c    |  907 +++++++++++++
 .../dcn401/dcn401_hpo_frl_stream_encoder.h    |  335 +++++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |  207 +++
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.h  |   59 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   99 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   37 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   19 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   49 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |   13 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    3 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   42 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   13 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   38 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   34 +
 .../display/dc/hwss/hw_sequencer_private.h    |    3 +
 .../gpu/drm/amd/display/dc/inc/core_status.h  |    2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   12 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   10 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |    1 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  176 +++
 .../amd/display/dc/inc/hw/stream_encoder.h    |  231 ++++
 .../amd/display/dc/inc/hw/timing_generator.h  |    5 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   15 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    7 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |    2 +
 .../display/dc/link/hwss/link_hwss_hpo_frl.c  |  113 ++
 .../display/dc/link/hwss/link_hwss_hpo_frl.h  |   34 +
 .../drm/amd/display/dc/link/link_detection.c  |  111 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  223 +++-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |    1 +
 .../drm/amd/display/dc/link/link_factory.c    |   44 +
 .../drm/amd/display/dc/link/link_validation.c |  298 +++++
 .../drm/amd/display/dc/link/link_validation.h |   13 +
 .../amd/display/dc/link/protocols/link_ddc.c  |   90 ++
 .../amd/display/dc/link/protocols/link_ddc.h  |    4 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 1185 +++++++++++++++++
 .../display/dc/link/protocols/link_hdmi_frl.h |   53 +
 .../amd/display/dc/link/protocols/link_hpd.c  |    1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |    1 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    5 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |    8 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |    8 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    2 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    2 +
 .../dc/resource/dce112/dce112_resource.c      |    3 +
 .../dc/resource/dcn30/dcn30_resource.c        |  126 ++
 .../dc/resource/dcn301/dcn301_resource.c      |    1 +
 .../dc/resource/dcn302/dcn302_resource.c      |  109 ++
 .../dc/resource/dcn303/dcn303_resource.c      |  109 ++
 .../dc/resource/dcn31/dcn31_resource.c        |  127 ++
 .../dc/resource/dcn314/dcn314_resource.c      |  127 ++
 .../dc/resource/dcn315/dcn315_resource.c      |  128 ++
 .../dc/resource/dcn316/dcn316_resource.c      |  126 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  131 ++
 .../dc/resource/dcn32/dcn32_resource.h        |   79 +-
 .../dc/resource/dcn321/dcn321_resource.c      |  132 ++
 .../dc/resource/dcn35/dcn35_resource.c        |  121 ++
 .../dc/resource/dcn351/dcn351_resource.c      |  121 ++
 .../dc/resource/dcn36/dcn36_resource.c        |  121 ++
 .../dc/resource/dcn401/dcn401_resource.c      |  121 ++
 .../dc/resource/dcn42/dcn42_resource.c        |  121 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |    5 +-
 .../gpu/drm/amd/display/include/audio_types.h |    1 +
 .../amd/display/include/bios_parser_types.h   |   14 +-
 .../drm/amd/display/include/logger_types.h    |    2 +
 .../drm/amd/display/include/signal_types.h    |   12 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |    2 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |    6 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |    2 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.h   |    2 +
 .../amd/display/modules/inc/mod_freesync.h    |    3 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |    1 +
 .../amd/display/modules/inc/mod_info_packet.h |    2 +-
 .../display/modules/info_packet/info_packet.c |  122 +-
 179 files changed, 15176 insertions(+), 120 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dml1_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_standalone_libraries/lib_frl_cap_check.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml_frl_cap_chk.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn30/dcn30_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn401/dcn401_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn42/dcn42_hpo_frl_stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_frl.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/link/protocols/link_hdmi_frl.h

--
2.54.0

