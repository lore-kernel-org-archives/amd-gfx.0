Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A277D6AAEC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:33:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4ED10E523;
	Thu,  2 Apr 2026 18:33:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nMGYeqa6";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1930310E523
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iErXXknM8lxDkoKWfGeWrok3/f+Z+rTFI0EvRJU5aJj3PXxhKtl1bg7V3VqmC0XUSEO1vbnF78hpQEwxRS3uviXV4O9f1NzV45gbmXRAUgavnKnMPGOmsUu37xcGtDjxg3bVJD2qRl18W98ojAvasXEaxMAEZ5ft5OaFJF/R4GfZsiaV3M25mRdPhPjvWpd5iKIwRkeBJkpzYy8VrB+en7cbEWx++qMuyZRCNoVB4dn2r+2PWNqeTl5qwB2Edq51g946IGHfq2hPcOnGvOAlyjiZVOKc92UsbkVGujUQkOxFa6voF7MGOIW9mOcDxwJja4F3VzbjwUz1pdfY0iANhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2ncvoo83sj8SCkMG+g25viMyrtBXIjJMCPr6vtMZcg=;
 b=X4wyfE3R4Dnc0/8k9a0Db1qHZrz5pOcZfFz0mEUb0v0tZkwdRc39g91jP3BOKyOz0aFWFI/D92N3R7POvDF0khS5emIUZ092OVxPLiwihlPyZZk8LCu1ib2l3n4581iPRnp3OF75/gmn3DQ6WPw6FYmSKjNgRZ2vfY0GnIdUUuq+iBqGUrA7I31mvyQPcXDzEfKGuNP2yzZUj92xUQ4d23pbskztplczqX8LPZaynofmaeFnavMNqqza8o8si3s42SgwlLXGr8/E2g9vGItaV13iQ2njHFrhy1grvGcnBWdxkCPIMM29LtsN7NQ1wWNCn6mOe63EcruqmTdnUz3AzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2ncvoo83sj8SCkMG+g25viMyrtBXIjJMCPr6vtMZcg=;
 b=nMGYeqa6wxWOZL+ht13bQVd3wX+uKKT/CatEdg7wEgwzhmV8bisi9BOK0KFzcxKWb1tEtiH3ZyCQJjRVF7kQ8NJu9bSStchBD4Cw6KhTvO2GJY47pFDvedCCwiYrHYJIqehT4ILDm/vp2ZvxFOA7kd71ChTiHHDjz4J87nDcspk=
Received: from CH0PR13CA0034.namprd13.prod.outlook.com (2603:10b6:610:b2::9)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:33:28 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::34) by CH0PR13CA0034.outlook.office365.com
 (2603:10b6:610:b2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 18:33:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:27 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:27 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:22 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Roman Li
 <Roman.Li@amd.com>
Subject: [PATCH 00/22] DC Patches April 02, 2026
Date: Thu, 2 Apr 2026 14:32:52 -0400
Message-ID: <20260402183314.1388755-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV8PR12MB9358:EE_
X-MS-Office365-Filtering-Correlation-Id: 055f9b41-a3a8-45ae-31c6-08de90e65536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: m2usrGdE/tm46w7HUUgrXih9NZnBiUfRen6m8MFc6BCt0FnwEOiSvcwwV+oGSAHyY5Oo+aAv2LR5stkpOTVSrpeEYJBhLKxhAOporNejDQyNCygmlzgp8FOXlb5YneXWYbdl0Fjh9LcqMYM7gh5QRjYKI8lS9X89G8ek4ju1BasY+7RclL9xtICnAxAwkIJB25KFIMZFjjfkB+y7SxgulIWpJi34RXox40FX95mF9utgkO9Hsw5K0JTgsA4ti23suM+fMN5sUWjd/DBmjjUs89b288ryl/5pLD4E13Gcnhq6W+cCFpI2/09w47ebNQLCGlrkH5z5irMBGnOds7usXM3Ue2E0qtSkuoJf5FA33OFGileH9XMR8Z4BJNi2UMXkAJ1CxUAn11jgLERG20hLVAbmxaVQ+3Y02xCpmXUaqeB1zMy1DV4I6sgbXmwWDXPQauB+R4jNgN59WD7pZniYcPIU1TO3irEssa8TcSJFeXYq07xSg8O4G8sQ7xwSna1xlMjEys40/HFXb8jsVbn0C6UEglGnoGM4ZG0cMDAGropMC+j0/O13F4XdNfjOIFG4D9fnOtFVXQrjaNtgMrI9CfeeZ4SgoEMDjF3wVQmgCIi9LNIMjCBH6ronSxuMONJbX7LXlTzG9E2AZpZ0uBVZuODtE2ueeT1BE17u3F/+C7/p2Rnm5qiDvhbMfUwM5vCg7qkVLmHBjuR2tNFEvAJPo9GnsmrGBoLpR7My4r0r7/84mCnMWrQK12kUiyYkoJG9s8EblY5q3r6uFfMqfHYEog==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0FukoNMTJyz5wNxGX7dliDo+LevBcHlHHUuMvGzyyVIqs9dLCnWEnI7w/j+4LdEqHmX2JHBmUyhnFEz0TFBjhnPIH2KDtO6V9NAilP79kM7AcLiRgwkpILLwvIC7ib+Ouaw04c67nMFQJGicWUio5PduWKCPpWAAz1LVP644Qy2L3+UegAa7iCqgFBlmsgMs8BIfyMQbj1XsnhfISE4ICzCNd3/4+fhY2ixa5Oto5N9liS8QNQQYclGgotsfxItR7IJS8KpYLbCUOU2/GQK30q9+HrnEjnaEukdetbv3QNNeuleaVNZZp7XfVVGa1Wqi6JiBwBZxnOMzMXdvNHUHUjbM7IKxpXR2taDGwZo8hArLPJY2ZMGVjC1bHSSF685UhpH0IlcVJ5X3AkJzgztcGajLpRliovhuw+Yxh5szLskgeHrcPwdfzi61KHLzTnsN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:27.9299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055f9b41-a3a8-45ae-31c6-08de90e65536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Enable sink freesync via MCCS with pcon whitelist adjustments
* Rework YCbCr422 DSC policy
* Update DML2.1 parameters
* Fix coding style issues and compiler warnings

Cc: Dan Wheeler <daniel.wheeler@amd.com> 

Charlene Liu (2):
  drm/amd/display: update dcn42 bounding box
  drm/amd/display: Restore "Move setup_stream_attribute"

Chuanyu Tseng (1):
  drm/amd/display: Fix coding style issue

Dmytro Laktyushkin (2):
  drm/amd/display: update dcn42 memory latencies
  drm/amd/display: move memory latency update to dml for dcn42

Gaghik Khachatrian (2):
  drm/amd/display: Fix unused parameters warnings in dml2_0
  drm/amd/display: Fix implicit narrowing conversions in modules

George Shen (1):
  drm/amd/display: Remove unnecessary Freesync w/a from DCN32

Nicholas Kazlauskas (5):
  drm/amd/display: Fix HostVMMinPageSize unit mismatch in DML2.1
  drm/amd/display: Correct MALL parameters for DCN42 soc bb
  drm/amd/display: Pass min page size from SOC BB to dml2_1 plane config
  drm/amd/display: Fix DCN42 gpuvm_min_page_size_kbytes in SOC BB
  drm/amd/display: Add DCN42 PMO policy for DML2.1

Relja Vojvodic (1):
  drm/amd/display: Rework YCbCr422 DSC policy

Roman Li (1):
  drm/amd/display: Drop unused tiling formats from dml2

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.377

Wayne Lin (5):
  drm/amd/display: Adjust freesync pcon whitelist
  drm/amd/display: Parse freesync mccs vcp code
  drm/amd/display: Read sink freesync support via mccs
  drm/amd/display: Enable sink freesync via MCCS
  drm/amd/display: Avoid to do MCCS transaction if unnecessary

Zheng, Austin (1):
  drm/amd/display: Remove Duplicate Prefetch Parameter

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  74 ++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 241 ++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  78 ------
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   6 +
 .../dc/dio/virtual/virtual_stream_encoder.c   |  10 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  10 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  37 ---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   1 +
 .../amd/display/dc/dml2_0/display_mode_core.c |  17 ++
 .../amd/display/dc/dml2_0/display_mode_util.c |  14 +
 .../dml2_0/dml21/dml21_translation_helper.c   |  24 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   2 +
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |   2 +
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |  25 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |  14 -
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   5 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  37 ++-
 .../src/dml2_core/dml2_core_shared_types.h    |   1 -
 .../dml21/src/dml2_core/dml2_core_utils.c     |  65 +----
 .../dml21/src/dml2_core/dml2_core_utils.h     |   2 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   2 +
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       | 192 ++++++++++++++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |  17 ++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  21 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |  10 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   3 +
 .../dml21/src/dml2_top/dml2_top_soc15.c       |   2 +
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |   9 +
 .../dc/dml2_0/dml2_translation_helper.c       |   6 +
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |   1 +
 .../dc/dml2_0/dml_display_rq_dlg_calc.c       |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   2 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   2 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +
 .../drm/amd/display/dc/link/link_detection.c  |  25 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   6 +-
 .../dc/link/protocols/link_dp_capability.c    |   5 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn315/dcn315_resource.c      |   2 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |   4 +
 .../amd/display/include/ddc_service_types.h   |   1 +
 .../amd/display/modules/freesync/freesync.c   |  32 ++-
 .../amd/display/modules/power/power_helpers.c |  49 ++--
 .../gpu/drm/amd/display/modules/vmid/vmid.c   |   8 +-
 52 files changed, 799 insertions(+), 302 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.h

-- 
2.34.1

