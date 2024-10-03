Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FA7CF34D6
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 23:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AE2110E1A4;
	Thu,  3 Oct 2024 23:35:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3BRN5y8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A84110E1A4
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 23:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZjUcRNMZxF3eibkIkQQBXcPSQjZYGOLZa9RiqfjTH2dxbknyM+/gycItEhPLc7sn0/1f6ZMb7jx+KVYKufb5pYE1hdUFGJb6GWX+zaYcDedNdOVs/1kKk6NclU8zsSJkEsvHNUvoRM8RgZpJlJO5NDbifc8F0muYF+qyaRvNSCDK0ALSl9Jq1aQJ2etltZH+/agUEqBr5Dvk6qN6PH5b7l7GrWl3Iflo+6k6WjbshA4cS3zngupX5hmCAkQT8LUWnBKMRHB2QwcBJtWkJ6JMl5OIuf8mTHjMzs11zh4RtAFibpoSnHPrUakGC7tFMB5wF8Pk9WlspjcSxTZA4pHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16a26dZBUBzY1tiudRi51v1Hxnti0quEPgsQSBKkPu4=;
 b=IhM8FB3IALCLKKL/Z+0UKS4fHfevj9GJkw707rMffYR+Mw+ifddYpMvnbESi5UMfb+kJMvZ/L5ONbneHvfM7d94mrrVgPhBJVUlq3sksGWkeIJEkaoOk4+mf+QPNoVyUcHqKTVsH21eLk2VZ6GvY8K12/KDJ4XW+cG1CEqax3tFjXCc/Yw9Xr8znCnJOLb/7BE5lgMdQzUDnfBIRUxVT6tBVDHrhUf/pLSNSTe8+P0zZd5tTTEkXYL6WiOiz2Rugb6RO5gtB+YR0eaBx8XLRHQjHqmuzapcRBr6pjRfECszZGQLelKUxqyuA/BFZWUTGN/68uf98sSD16VfoqwdnsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16a26dZBUBzY1tiudRi51v1Hxnti0quEPgsQSBKkPu4=;
 b=D3BRN5y8eNDdrxZ+7ETGx4vNupT85g4AbuS2ruCmkOEiQ48fPpICodTELsGiGPVIN/YD7FNHvYGtVbPE3/OX903XHBSuBIto8HYLRjiwbNkZ5KHWi9dE0Fwq4awp32IiYfp/wtPU3jVoBjpcasJHKLEC+/la7DaOQzAQLd+s5B0=
Received: from PH7P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::12)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.23; Thu, 3 Oct
 2024 23:35:37 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:510:32a:cafe::cb) by PH7P221CA0029.outlook.office365.com
 (2603:10b6:510:32a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 23:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 23:35:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 18:35:35 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH 00/26] DC Patches October 3rd, 2024
Date: Thu, 3 Oct 2024 17:33:18 -0600
Message-ID: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: d1862a34-785a-41cb-76ef-08dce40415b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cD8Miiy325nykfakWpzvdEVDeK9jC5RNRDWcVORQK4/WPH3D6+8dzdYX32KY?=
 =?us-ascii?Q?6k7BJ/0k6zN4DecWfDOU2Ihk6ZxOJOOULCLn1D9MfWsB0KzUFInPbbM39BNl?=
 =?us-ascii?Q?VUr+69+h7jKowWLVohFTbCiDyzHqG/JHI+jJDjIwRU97zh+U6v2G00RxuR68?=
 =?us-ascii?Q?zD8MnXrdlHWysfTXGAHdEy+x2jXt/HvF89GMgx336CbKguRVKU2qCcv/3CHq?=
 =?us-ascii?Q?CaTzvc3NoHwb/zhwSHPaSHfoL/0mYTagw6izbJwY7UHLTxuM+Sv23CkW7O0a?=
 =?us-ascii?Q?m+y/Ra+Zbcn9ej5jdsB5NrJcgT5+Dtk/jgK26IoRD6A8sNPbJxwR9gAh2EWO?=
 =?us-ascii?Q?pn+ckQL43FLQMeQ2aifgY2pjZ8LW8Ja2cqtR32dmcgA9sYc08W+VfaJLgw7I?=
 =?us-ascii?Q?eriTnPuJhkaYY2kB3y+J3WIYSeajEc6Dwr2vMHw/1tF0Nw+GjMD8m4FZphq/?=
 =?us-ascii?Q?OTLaU7Zb2e17AIk4/nYz6hhAa3/Cci2Ono8yJgDUH6/WtihQyXwMk2GmfRie?=
 =?us-ascii?Q?3CEaeSgKTrY83FOKJDgs46QnXXWrPNhgQsNbbKdbuAR8J70kiHsfMdBW3qBX?=
 =?us-ascii?Q?Cj0k94lTZB9Sw6gkDaCrHagEvwv8iSxqVOiYgSo8i1nLQuUd33knYtOyL8AG?=
 =?us-ascii?Q?Y96u1qF9ar3YdVVBP4IJKS0NR5mvGnowxhbCswc2LwRRl0YsC8Rpn4ReWBPI?=
 =?us-ascii?Q?gPPRUGPSMFoAtV5uNJ3Iy1BCz1J42ZgFcb5kO0T19SljdfDu1nTzFfcXGL+5?=
 =?us-ascii?Q?MZMFXL3Dy2thc5Rrw8r+IG3uVWSB+NXfRmXQjvuFqY2poU77b/0kiESmLGkK?=
 =?us-ascii?Q?6JJ2RLT/8CEQXT10J3rG4ZuTbZXcg4JZnNeQzVLrEum3IjWruB9j8MSm5pRK?=
 =?us-ascii?Q?E2QT8j5fiyI4cLSnv38DtJhTLbi5dNQvOXzlniqLe/KRnUs75DiZ2yoeEMQH?=
 =?us-ascii?Q?cYqMUEHVyiAI/WVXiBGcod+cYY2JWG0t3tDV0cwbp4osbE2T2Kipyf4wW3fF?=
 =?us-ascii?Q?b/PLPdi1UF0NdgG1DT4a+u4a6gdMrkcD6k+LkKUtArzDwbIb0vNZoV/4klDA?=
 =?us-ascii?Q?SUEJEygBZh0zfDk+x/gGZqA+Wg4b8AVUckceksfoZgtYLba69sWX+YQmyoDG?=
 =?us-ascii?Q?cfgbWMzCbZ2gM97EF+H+y1yZ7ul4h9u1/cY2Hkqyi4ikXbjMZCC6CahS5c9b?=
 =?us-ascii?Q?gZJCVqTnqJp37h6ZWifU7SBjr6g3X7MDPyO6AbtJp2joWCSxWZ9EfA/b/TTw?=
 =?us-ascii?Q?o/84kqFLitycpi2ODByk4aKJJ7auJJ1TUqacgRtWSQCoG8uMAVbCwqEDa5B3?=
 =?us-ascii?Q?H0+BAFPGzjTvhStU67F1Zmb4D6b3bErUeZermQX/+5XbbN1u9kcI7AYhIG6/?=
 =?us-ascii?Q?AejBcD4MZ4lrOzaMS/AlkkRJT2D5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 23:35:37.3265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1862a34-785a-41cb-76ef-08dce40415b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279
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

- Improvements to seamless boot.
- Adjustments for DSC dock.
- DML improvements
- DMCUB fixes for D0/D3 and new register offset.
- Code cleanup.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Remove unnecessary assignments
  drm/amd/display: Remove redundant assignments

Aric Cyr (1):
  drm/amd/display: 3.2.304

Aurabindo Pillai (1):
  drm/amd/display: fix a memleak issue when driver is removed

Austin Zheng (6):
  drm/amd/display: Unify blank_phantom and blank_pixel_data
  drm/amd/display: Flip All Planes Under OTG Master When Flip Immediate
  drm/amd/display: Revert commit Update Interface to Check UCLK DPM
  drm/amd/display: Allow Latency Increase For Last Strategy
  drm/amd/display: Move Link Encoder Assignment Out Of
    dc_global_validate
  drm/amd/display: Update Interface to Check UCLK DPM

Charlene Liu (1):
  drm/amd/display: update sr_exit latency for z8

Dillon Varone (1):
  drm/amd/display: Remove programming outstanding updates for dcn35

Fangzhi Zuo (1):
  drm/amd/display: Skip Invalid Streams from DSC Policy

Fudongwang (2):
  drm/amd/display: skip disable CRTC in seemless bootup case
  drm/amd/display: force TBT4 dock dsc on

JinZe.Xu (1):
  drm/amd/display: Noitfy DMCUB of D0/D3 state in hardware init

Josip Pavic (1):
  drm/amd/display: Clear update flags after update has been applied

Kaitlyn Tse (2):
  drm/amd/display: Initialize replay_config var
  drm/amd/display: Initialize new backlight_level_params structure

Peterson (1):
  drm/amd/display: Fix low black values by increasing error

Roman Li (1):
  drm/amd/display: Align static screen idle worker with IPX mode

Sridevi Arvindekar (1):
  drm/amd/display: Assign socclk in dml

Taimur Hassan (1):
  drm/amd/display: Add DMUB debug offset

Yihan Zhu (1):
  drm/amd/display: calculate final viewport before TAP optimization

Zhongwei (1):
  drm/amd/display: Fix garbage or black screen when resetting otg

po-tchen (1):
  drm/amd/display: Display lost signal on playing video

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  32 +++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  13 +--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  13 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 103 ++++++++++++++----
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  57 ++++------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   4 +
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |  25 ++---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |  25 ++---
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c |  10 ++
 .../dc/dml/dcn20/display_mode_vba_20.c        |   3 -
 .../dc/dml/dcn20/display_mode_vba_20v2.c      |   3 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |   4 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |   4 -
 .../dc/dml/dcn21/display_mode_vba_21.c        |   3 -
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |   4 -
 .../dc/dml/dcn30/display_mode_vba_30.c        |   3 -
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     |   4 -
 .../dc/dml/dcn31/display_mode_vba_31.c        |   3 -
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |   4 -
 .../dc/dml/dcn314/display_mode_vba_314.c      |   3 -
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   |   4 -
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   3 -
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  15 +--
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.h   |   3 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  20 +++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  46 --------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   5 -
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 -
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 -
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 -
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   8 +-
 .../drm/amd/display/dc/link/link_detection.c  |  12 ++
 .../dc/link/protocols/link_dp_capability.c    |   7 ++
 .../link/protocols/link_edp_panel_control.c   |  11 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   5 +
 .../amd/display/modules/freesync/freesync.c   |  17 ++-
 46 files changed, 269 insertions(+), 239 deletions(-)

-- 
2.45.2

