Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EAACA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAD910E5B6;
	Wed,  7 Oct 2026 17:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gFwbDY7Z";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010026.outbound.protection.outlook.com
 [40.93.198.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246BF10E5B6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BvtbJfrYkf98fKav3h6gx3ITV9IzhFQCAZvvg7RvGRJKSCIthLj+iYrUZkrBlN0girxSggPj1t0GrR2yt1XqQ6Cz10r/wLXigN3kYX+b6Qy2pzx/ZbhyckVmyXHkQBQ+NFOPkpVFB2wlCbs6VjN0DojRbdlsegO3BydJ4Q13JJyDrlggVw8/l0HCxTo1et3j6hiSOePAek1YZt1aOeFwH5L5qkFGRJgzEkrNrQNeysBZEy+fA5h07ZhFkuAoiOC5M/xhedqog4rPN6NitM7mQ4heKj8rv7u2FEg89Hw5qHJsBERBuKO3M09weJH6YwHtJi9pgO/tQjjJQxk5hgT7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4YHzfF5fKFgpnlVqpB6/Y5zJptqzLsIkQ53T/qeED8=;
 b=bzFirBhAMbNmW5tdvhEhuWKij5Kkx1QOf3ivL1zqa7MOu21/TkvxM9JunYJnzICQkQheckwVD4/fj5NV6YlQHqBYsVAit/5anWLNBjHSZ70ZJqkDrOn5WDWDvX1JmaxypzhT5vXQLuZGBoBnRrgZ0OU4ozX0kqap5lXIyuByvsRbno/4BBSgfynBJ9pJwkKPcYrF0+etzGS6qPUVTUoh/8VZ6cgQwOYM9v6hoQ7ENGbdrnwnHZY7JasWyiDmmiSBS69Ic4I9KcPePtnxEUCbbk2TLFgzK2Nt8gmxkYeSijYQtF94BNwugyDmm6nRMGkXDLeZ3QUV4rmeFjC0yMw0Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4YHzfF5fKFgpnlVqpB6/Y5zJptqzLsIkQ53T/qeED8=;
 b=gFwbDY7ZU3Tdr0lb/LoGrEx7QZBfP0vHHW2HoPrqGIxWw7pjQUmDmlrBaN1uE6DGSVqAfTiSIiPNUmwVJBZsP6ikAYg4At4kDa6Yjx4CuV4Kb4Pu7zyTH6N9qbcPNCI/w5AoUz4gLRbN/gjwln2f5xQnss4KFdev36wXa6unlPc=
Received: from BN9PR03CA0644.namprd03.prod.outlook.com (2603:10b6:408:13b::19)
 by DS4PR12MB999102.namprd12.prod.outlook.com (2603:10b6:8:2fc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:18 +0000
Received: from BN1PEPF00005FFD.namprd05.prod.outlook.com
 (2603:10b6:408:13b:cafe::af) by BN9PR03CA0644.outlook.office365.com
 (2603:10b6:408:13b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 7
 Oct 2026 17:04:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFD.mail.protection.outlook.com (10.167.243.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:16 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:16 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/19] DC Patches October 5, 2026
Date: Wed, 7 Oct 2026 12:59:33 -0400
Message-ID: <20261007170412.1898315-1-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFD:EE_|DS4PR12MB999102:EE_
X-MS-Office365-Filtering-Correlation-Id: 373a7f9e-b95c-4570-56a9-08df249505f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: AJJiExDYcMjjOah973C8KEO5fMXm/IBo3jKHGmxLzr1aVnBekQbLcC+ZU6Y8jCZ+yCLdG2WB18mKZDcygC6IGwQTHo39dkey7mepOQrfBoPok2XLWf9OFb/XBw60SDjEWkXTvw8B10Rya0KzSP6W5xLCNgXj1kvMPk49dG/yixfvtwJou4wItFYVmu+BTOkl6F+pc660l4krt+FTKQAoe0qFbmTCsBZRcaDvDXlQhiJB1HmAUBuZiN1vV2BysYyO1rFPjao2XcyYTutOdGCR3VAd2qZrKf+eBI697LKmrCVJxAGzwPpPcwcDrpbyvGzNHM5aMf1Uqwrne4UB0UatWMb+OJH83F7s4Wa08QrQ44RJecoEumxGOGPZ0kCBXL5OZWUArEKTk0RRMxtP2syYwpuzgObg6k9do0xt3MJB0nQuwmgySaJ8J6ALYEHq4Afwwq+DVLrxITvarfebdeNaPFGTIWRU0w7rZ2WYm+mH8U6gougie66gW8ymWo3BXQwkIoH4JMa82Y5/2S8uWy3idYLnjfdRNjMyl7u3MY7n+Zc9gOpXQyD/7eOMZpvmNnKRoiHUtlNMh3NpPXItrGGBtxWfstlzKbPom/f3Xo7ArYWj4sVQgSDJLnSDF0BZwTG1Ar6CdrmtCgSmmWYU9a7jYwH7ethj7UWynawaoxA+ak30UqBT3GOYyXa6qqm2VpZ1ufsGYttsZzAFdZbaM2Bm8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NtQQkPXzztLrHRrSUwx1pUpiNByNVsU0wZoTysb0J1Hj/yiDUvACJubMkGQDoM9meDUQmu3TQAwQSIQsQjYac6409d/yhg/ySnxvz+pkYBbScaWusPZdseroKW+Ia2JosGV2VEJCCfP1owlhLLcXtsA+nBVEkoh7R0RCRVGcmmGV9o5gVdbgwFralgz7P9xsRnEqBUY/KQzQXChbCVkAlvh3d7NvH8cu5Ccl45TsaLSCR2LJCIHrKQBT6KrW0wueBUhAu5oMVTVO67CjDLFhTCnqLbZ/W/0XlEO7xh0+bNKBKGa0rxgL5Y2yvPOeXf+L7aop9AGQqWlkH4/i1evVpPF3pvid3YtfCNJdLWzMhuHWri6716bY/12Tioo7lHnvXnvQVWZ97vP8fy9KirSBhID14MPvkVrdK6dEda84HKyeJ/H67dJor1sre+01B+CX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:17.8093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 373a7f9e-b95c-4570-56a9-08df249505f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB999102
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

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

 - Refactor DC IP request control in HWSS.
 - Fix rotate 90 degrees surface corruption issue.
 - Refactor DPP root clock control in HWSS.
 - Fix upsampling and linear scaling.
 - Use aux hw inst if no ddc pin exists.
 - Directly include compiler_attributes.h.
 - Fix frac_urg_bw conversion to correct U0.10 format.
 - Do full link training during HDR/SDR seamless switch.
 - Fix SPL format handling for linear scaling and upsampling.
 - Update DCN42 cstate latencies.
 - Invalidate the DRR shadow after a hardware re-init.
 - Program HDR visual confirm based on per pipe info.
 - Split link_set_dsc_on_stream into encoder and DSC components.
 - Add new config_dsc hwseq function for DCN60.
 - Program DSC prior to OTG enable starting DCN60.
 - Improve mandatory pstate optimization and check.
 - Disable HUBP/DPP power gating on DCN42.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Use aux hw inst if no ddc pin exists
  drm/amd/display: Program HDR visual confirm based on per pipe info

Aric Cyr (1):
  drm/amd/display: Invalidate the DRR shadow after a hardware re-init

Charlene Liu (1):
  drm/amd/display: Fix rotate 90 degrees surface corruption issue

Dillon Varone (1):
  drm/amd/display: Improve mandatory pstate optimization and check

Dominik Kaszewski (1):
  drm/amd/display: Directly include compiler_attributes.h

George Shen (3):
  drm/amd/display: Split link_set_dsc_on_stream into encoder and DSC
    components
  drm/amd/display: Add new config_dsc hwseq function for dcn60
  drm/amd/display: Program DSC prior to OTG enable starting DCN60

Ivan Lipski (1):
  drm/amd/display: Fix FreeSync caps tests after common EDID VSDB switch

Karthi Kandasamy (1):
  drm/amd/display: Do full link training during HDR/SDR seamless switch

Leo Chen (1):
  drm/amd/display: Disable HUBP/DPP power gating on DCN42

Ovidiu Bunea (2):
  drm/amd/display: Fix frac_urg_bw conversion to correct U0.10 format
  drm/amd/display: Update DCN42 cstate latencies

Rafal Ostrowski (2):
  drm/amd/display: HWSS Refactor - DC IP request control
  drm/amd/display: HWSS Refactor - DPP root clock control

Sridevi Arvindekar (2):
  drm/amd/display: Fix upsampling for linear scaling of subsampled YUV
  drm/amd/display: Fix linear scaling and upsampling

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.402

 .../tests/amdgpu_dm_connector_test.c          |  30 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  43 ++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  93 ++++--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  19 --
 .../amd/display/dc/core/dc_resource_helper.c  |  46 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  |   4 +-
 .../gpu/drm/amd/display/dc/dc_memory_pool.c   |   1 +
 .../gpu/drm/amd/display/dc/dc_memory_pool.h   |   2 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  22 +-
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   4 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  21 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |   3 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   2 +-
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |   8 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   7 +-
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   5 +-
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  10 +-
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |  20 +-
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c      |  13 +-
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |  97 +++---
 .../src/inc/dml2_internal_shared_types.h      |   2 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   4 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   3 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c  |   4 +-
 .../amd/display/dc/dpp/dcn201/dcn201_dpp.c    |   4 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  76 ++++-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |   9 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   4 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   3 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |   8 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |   4 +-
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |   4 +-
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |   3 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |  38 ++-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |  15 +-
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |  13 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   9 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  13 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  28 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  23 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  21 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  20 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  24 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  27 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   1 +
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 101 ++++++-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |   1 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   9 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 282 +++++++++++-------
 drivers/gpu/drm/amd/display/dc/os_types.h     |   1 -
 .../dc/resource/dcn42/dcn42_resource.c        |   4 +-
 .../dc/resource/dcn60/dcn60_resource.h        |   6 +
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  52 ++--
 68 files changed, 874 insertions(+), 435 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c

-- 
2.43.0

