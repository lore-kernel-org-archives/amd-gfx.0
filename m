Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3791EC52D7C
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 21:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D516010E6F1;
	Wed, 21 Aug 2024 21:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Kh+2fXfn";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C30FA10E6F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 21:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o6ep68OA/GANa0z0qvTkloNHlJnFel0Ft/Hy692Or3Ldn+Cc4PSmkgvrQAlsXgiW9allvAtURgrkBoaDQ5TgR+jz6yDsDpp+/yQfWCp9tn1xjfa2b/FW15nNQ51LQbn1AJdIKA6gHXi/EyZOs1pU3AIPXX1on0Pa5qCapCyOEfGqbuAnS3sY7JuIoIPMBc4Y4SEZOILSMJtER3XqwDh7OHDj1I9uvWGe9jSksiTn8sYkY5RIehMeDaJwWQ1yk+Ij95IbJwuAWDV4gTMc1cxvKTv9rqnEM0kxtA4Qr66GmKaO8Y1Oawr8BOAJrH+X5VqecnJlBPcAY8SyR7ek0evBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UNq8LCftx/yolwUxna5juPEg0qFmZNEAVzwcut2HTec=;
 b=SPpWkLzb2v7UVbYdcH09Exr32I3l5prkfmviMgArV2pducLRdtY/u4hNH/5qy78PtF3pkZC11QvP90JJNW3AGnm65HtyzpWRXXlDHIRQBzQWD56q8bm63RZLGqBe1tp0FYgO69YfXLNoVfsjm1Hulldgw1oine62DU7p3WYihhaSVVacxXndmznYBH7si36pKTZsVV6cFJe+zj76mzRyZvMXMZ7UljKYKIUpSAssyo/BzkPGte9Bpuk9VY6L1je/a7oLUSGBSzZWu9q+cZ7NbYR5JDSFhgLAumQaiQl/8KduumW3wkOQDGlJFJ3yoy07D70M8v+gWkMsxUCKrVSoLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNq8LCftx/yolwUxna5juPEg0qFmZNEAVzwcut2HTec=;
 b=Kh+2fXfnmjRcpTkEo5DWSnK2mheqod+Nu2H+W1Z/QvkpEIRhFVwf9neKAZxCI5vNJ4sDD7v/Jgbj7hR788kD1IFD8w/I7bghAZ0k564GOdRcUWTma0NuHOnHsn6DP6e2o8gHKOpGTMjRRbbPnC7I5zLE412bi3oDUS0/PQduIYE=
Received: from CH0PR03CA0392.namprd03.prod.outlook.com (2603:10b6:610:11b::31)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 21:52:41 +0000
Received: from CH3PEPF00000015.namprd21.prod.outlook.com
 (2603:10b6:610:11b:cafe::8a) by CH0PR03CA0392.outlook.office365.com
 (2603:10b6:610:11b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Wed, 21 Aug 2024 21:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000015.mail.protection.outlook.com (10.167.244.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.4 via Frontend Transport; Wed, 21 Aug 2024 21:52:41 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 Aug
 2024 16:52:39 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/16] DC Patches August 19, 2024
Date: Wed, 21 Aug 2024 17:51:57 -0400
Message-ID: <20240821215213.1496781-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000015:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 57cbaf94-5f13-4a4e-e38d-08dcc22b9491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TR3DuveJk4dyTvRmozlOuWJhoMH5BK2hYd/jAEI49DGiigWNdaFh+RoMzcNQ?=
 =?us-ascii?Q?C7KwnHWDRgOsJ7lzWY2AEkzUVzT750JVYKodpQLJcE3pAISY4WafhNxk/rjH?=
 =?us-ascii?Q?74QoyIMGQJvLRc/C0+5znCMk6yhms5nC+3cvZwAztBfePHFfLZOL+qtO3LEL?=
 =?us-ascii?Q?ZOpOCWv/bLCwIlZDOe0V6dinqqUGfEvp3GXUhODxCRXGG4MkBAup7KIy6Sgp?=
 =?us-ascii?Q?hLVo1SoqDZgd7WwzGMnUDJvhPl6q35K8773C6vW6UFB+Lj5fspnI4hTi4YeP?=
 =?us-ascii?Q?0nGHCHIANbFWUFdks8iZ3Vm9Ou1Dk6kQKgnfiubBv2Udib5IYy2/VGny7cxV?=
 =?us-ascii?Q?kEt332SUdxZ+m2s5hIy9JUoHxDH0QOfuN2rTg9Z+DuTCWcAOwcaxfs2lCxwM?=
 =?us-ascii?Q?vn5oOUmynaTM3E/8ElZnnZPsMlJltDciXPmQCBQLJRHXw4a0wcZrx0U+71Ko?=
 =?us-ascii?Q?ybDw0ceocd4ZoJU7FGyG9tQ9XBMbo6mSxutsnmeP9lqXsOPzMyvHUERA1nAv?=
 =?us-ascii?Q?h28nHhHJuG2j6yfiCaZIUvC57b0xepGmx/+f7R+1QLJixTd/ZCgGZYYA4jTV?=
 =?us-ascii?Q?A4ejk6cxr8qfqvLa8s3uXMQc09hIVB7dABn4UnedF6vPvLerw+8pTWwbNmyX?=
 =?us-ascii?Q?MfnPylWLGO3sdG9wr/FyB1uK4NZwYTtdFbu9uJv8LCWaqIXhx3nxM0GZWZWb?=
 =?us-ascii?Q?5z2jsXsXrAo5Dr01sagreafuuS3qkKaUsbUbDJyQGvCbboVuh2kCJmENu9tx?=
 =?us-ascii?Q?w3qSIbEOK7LH5dHhmZ3WLPmmVcg7Qe3sg67PdOWI+KmW9knbB7+aLd3qWhiX?=
 =?us-ascii?Q?aWywWMt3+byvwoUQY/hGKHGdSW4ThOqOSY/RzD+gP40UzjGBsg5//imB8lgn?=
 =?us-ascii?Q?himySStcwQvz4mGMjmefjhJeasRB9u0oiEuMQMqAr6Fx+g5RJ4dsbelcVvuV?=
 =?us-ascii?Q?JJytRzO/0vPKMlu3AlK9GH/4iihAWyaruAZJTbMStCPv44y/4vEP0MMfBQl7?=
 =?us-ascii?Q?ajpWMsI7naLmIRa+gNgES1l8P2INXjQZI+EzBL5MVUiP51V5d5i/D0Th+rBo?=
 =?us-ascii?Q?aHW2n8ZVFIVT1ukZW2XVAPG4DjWPGxOA1JhIea+xGXQHWEL1MUNM6Gw4ZjPs?=
 =?us-ascii?Q?GPOjNhcRe9kZ5iy/uFifIZfO5nzUDkB+SL+hQgP1oEBGS9NSoHI05jY3y7+E?=
 =?us-ascii?Q?RFDTMPZV7q48mzkXBZttP5z6G+zSt8ET72CDznIWThKo6jfqP70bCPE/nTWc?=
 =?us-ascii?Q?slgfhNauNlnZCe3bvuzH16VAzw+rkrcUJtGdiuxpNzPH2DcQjD3QsyjIkZmj?=
 =?us-ascii?Q?qHJsUnjJP7VTIqfIWkq46ztuPYtnu2F6HffFoqd96g4cJ4bYzo4KopCcS+Wr?=
 =?us-ascii?Q?GPj+T8xDLQKmRtSJCotVQobgbYindU3HrNT+uRU6SHQmNyyy1P0Un3sAlZzO?=
 =?us-ascii?Q?Zwrkkfk+RIsdnC2/1N5c9XJIzV8QET7t?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 21:52:41.0957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cbaf94-5f13-4a4e-e38d-08dcc22b9491
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000015.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* Fix MS/MP mismatches in dml21 for dcn401
* Resolved Coverity issues
* Add back quality EASF and ISHARP and dc dependency changes
* Add sharpness support for windowed YUV420 video
* Add improvements for text display and HDR DWM and MPO
* Fix Synaptics Cascaded Panamera DSC Determination
* Allocate DCN35 clock table transfer buffers in GART
* Add Replay Low Refresh Rate parameters in dc type

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ahmed, Muhammad (1):
  drm/amd/display: guard write a 0 post_divider value to HW

Alvin Lee (2):
  drm/amd/display: Don't skip clock updates in overclocking
  drm/amd/display: Wait for all pending cleared before full update

Aric Cyr (1):
  drm/amd/display: 3.2.298

Aurabindo Pillai (1):
  drm/amd/display: do not set traslate_by_source for DCN401 cursor

ChunTao Tso (1):
  drm/amd/display: Retry Replay residency

Daniel Sa (1):
  drm/amd/display: Resolve Coverity Issues

Dennis Chan (1):
  drm/amd/display: Add Replay Low Refresh Rate parameters in dc type.

Dillon Varone (1):
  drm/amd/display: Fix MS/MP mismatches in dml21 for dcn401

Fangzhi Zuo (2):
  drm/amd/display: Fix Synaptics Cascaded Panamera DSC Determination
  drm/amd/display: Add DSC Debug Log

Nicholas Kazlauskas (2):
  drm/amd/display: Allocate DCN35 clock table transfer buffers in GART
  drm/amd/display: Notify DMCUB of D0/D3 state

Samson Tam (3):
  drm/amd/display: add back quality EASF and ISHARP and dc dependency
    changes
  drm/amd/display: add improvements for text display and HDR DWM and MPO
  drm/amd/display: add sharpness support for windowed YUV420 video

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   18 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  133 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    5 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |    6 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |    3 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    4 +
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |    9 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 -
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   30 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   24 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   52 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.h |    1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   19 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   18 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   11 +-
 .../display/dc/dml2/dml21/inc/dml_top_types.h |    1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   68 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    5 +
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |    3 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    3 -
 .../src/dml2_top/dml2_top_optimization.c      |    1 -
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  568 +++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   27 +
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    3 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |    1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |    4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |    9 +
 .../amd/display/dc/optc/dcn20/dcn20_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn30/dcn30_optc.c    |   45 +
 .../amd/display/dc/optc/dcn30/dcn30_optc.h    |   13 +-
 .../amd/display/dc/optc/dcn301/dcn301_optc.c  |    3 +
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |    9 +-
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |    9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   16 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |    7 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |    6 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |    4 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |    6 +-
 .../dc/resource/dcn32/dcn32_resource.h        |    3 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    7 +
 .../dc/resource/dcn401/dcn401_resource.h      |    5 +-
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 1361 ++++++++-----
 .../drm/amd/display/dc/spl/dc_spl_filters.c   |   15 +
 .../drm/amd/display/dc/spl/dc_spl_filters.h   |   15 +
 .../display/dc/spl/dc_spl_isharp_filters.c    |  460 ++++-
 .../display/dc/spl/dc_spl_isharp_filters.h    |   35 +-
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 1726 +++++++++++++++++
 .../display/dc/spl/dc_spl_scl_easf_filters.h  |   38 +
 .../amd/display/dc/spl/dc_spl_scl_filters.c   |   91 +-
 .../amd/display/dc/spl/dc_spl_scl_filters.h   |   55 +-
 .../display/dc/spl/dc_spl_scl_filters_old.c   |   25 -
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   45 +-
 .../drm/amd/display/dc/spl/spl_custom_float.c |  151 ++
 .../drm/amd/display/dc/spl/spl_custom_float.h |   29 +
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |   25 +
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  497 +++++
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  525 +++++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   38 +-
 67 files changed, 5210 insertions(+), 1114 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filters.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters_old.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_custom_float.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h

-- 
2.34.1

