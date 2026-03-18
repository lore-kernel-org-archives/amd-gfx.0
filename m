Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3832BFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBFC210E074;
	Wed, 18 Mar 2026 01:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cWElc/s7";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 246D710E074
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZufMuj3IrMBTFHADwjiSujK+DlZvGDnMux9PxRF2CC5rWD1ZtEMtzyasVSm0XXYYc+GaMziuHyw6w397Jft3IDo7qSU+TNH6YyatcAz2Kn+/qNSFAFk+tqCFTKh31e9ulGbeUjoB5QS1bwP+jHQL/cKrABV2BlPikF5cfSW4+nJCMWAyWNRwC+qSYoP896+WExt2FbzN0IcnQfZzT94IgOw73ZUPM60998bViJIQXwyfodZS9e52GVI1Uj7ilOlavrfe0i8B0IWdkkJwLqaLTDus/fLky/wHNpBnp0qykBiD14s6x79i+kSRUGd6RmmJxGKfvGK2JBNN45xEBZ86ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74DgE1FuVjH0uN7f8EG0FCMywhRMw3tU+LJjq2fFUdY=;
 b=RgDD8hP0RhZzdVz13WHKWcMm7Dv6Q6+8KVytHh5si8xXehPfz9v6ICHSGYTvePPjz/aDludauPR7P0Z566b4Yhh72yV4N7jcnJaq5laB+Jfn8G+HmKTYsyrhIAM82ujTqTDxLzYBsb1KM/g8svz7Qg1xHO5p+RldmuyGbyGZyUNG0T8irOERSp/uHNFGrG+/nBWXmfEgxqUq7U5B5nD+7egl/n0W9ZZQ5eJ9gU00jkEnlXEzM+eQ1IACma5eRcMfpKAvdqfHST7mhTNK3OVvZuwapFISNur0CYuTEJnd/MTo4HiiC9ymUZW5oMMbYNvQP0Z4VtVzCBSnsZ+T+mnxzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74DgE1FuVjH0uN7f8EG0FCMywhRMw3tU+LJjq2fFUdY=;
 b=cWElc/s7entLcaZb6afwQnzJWd3fnc14ArPVTAnqxJR6nTa6N88eYrlJwar3YQUcC0uz4REMtShGjIK49CjnMEiCSBN3SDUdyVQUu8w9O/xJ0xW28zDXV5js+9X8sB4M8oQulb0xvnbqaNXl2oF7vEWI/APM9Uo1ssz8gZ2fPP4=
Received: from SA0PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:d3::8)
 by BY5PR12MB4289.namprd12.prod.outlook.com (2603:10b6:a03:204::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:01:00 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::a0) by SA0PR11CA0003.outlook.office365.com
 (2603:10b6:806:d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 01:00:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:00:59 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:00:55 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, ChuanYu Tseng <ChuanYu.Tseng@amd.com>
Subject: [PATCH 00/31] DC Patches Mar 16 2026
Date: Wed, 18 Mar 2026 08:59:09 +0800
Message-ID: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|BY5PR12MB4289:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1f1c64-208a-4168-17f4-08de8489d1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: g7rIO8ftK1gWUNd0ZYajIFoT0wvZtqcnzcewJekmqdoUDPNfX6QUlANd8wWisKCI1MfLOY1v6gx8ZuD8baujsfLBOPi2oZ1z+lB+l+I5q7yFr2dkml9ufeNXYDoL8ZLMx3SDiRLBKN4XtzgK9pCI5sRJycw2E20nsriSt4ETUgCDpdMcNkug2I7GEmHlbho6hwAO34kEjgVnNNv1gQwNOUhG72nYlU9cjaxpNkhRuWrt2rvN/UvJvEMESPmJ/Wf9OayYnwBcnEA3ovRspgMPnal1Hl5uubruk9+8gWdu/nEJkSEnN4NDj+nT2Oydm1rynrx6vD8SKTtnDtl0brB0px7kCBhaHA6ytTyKRliPbLvrBpv2d8tuIrWGeqpLaO6Ww2YtVS+kz9BW1u+WwxrkWyrXzrJFQ9eRHtjT6X7vs8JnZtf40H++5oTkh310Rts9o7awkRWFMIPpbKVzfZDmhuhIaoygHV7Zzt/rQGtWy8JQzeGp2wmroLyLY9kpQiTpJB8jlqcyG2Ce2FgIrsQ6LN46l4KLu2r7rKfMnE7AYst+WkhYBofN7a7En5ocsBvFclYc+anbmINZ4KG5L3mWz9UVB0lvdcWWQK9o7qPoH37Q9rKjPs/X8vnac/nKxg7/dw8tbxsqlXTeRTTVwksK+tyEVYEB8bKL5rMMV9ofthofdu+SR1CMGlUnrjetJpk/N7GAYP/3CsKLEjbVEb2Y53y7uWf+gM9epyGMahTaSpWNRTYy6miXqC8XjZp0qcUD1k+jpVgVTd0YBd9qrrGyEg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q9unB7eMHHjJozdUQskERAa/d0VgJai3J+ZlgAhPGplaR0gjjOrWX/K9f6GDzU5M79WL2RoudQaeY89ZqY4W8y8sijGczyRTAv28piJgdnjzqzH7fqvqqgFyikdljrbzS33Go81ol5gWQZEKqWsuGw6QFOCtOIl2mtKmmFe+rslm9u61MuE9zn1mPv4aWttiAbs+5/sXieS+V1x8n6gfJnoCoNsJEc+vddnHSn64BNyNH6O9GZZywX4j3BV3sbc0fAgI5vpLXoNYOk05ysU/zHEoBalUzIisw7Atn7otQc8K62o1YDRNLG2JW4JyCfBrQbULxpiluzYT0oxLQhHREUUfNvinwcRzP6o31Oha1ccqpab6UHuf5544T4lJ9EoQ0b/mr3UYjwf7MvbEvLTp+wz+rFExKGW65aDqe7LubzQbysHLvLaRHVr2f7+pKz+h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:00:59.6246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1f1c64-208a-4168-17f4-08de8489d1b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4289
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

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Rework YCbCr422 DSC policy
- Restore full update for tiling change to linear
- add dccg FGCG mask init
- Remove unnecessary completion flag for secure display
- Agument live + capture with CVT case.
- remove dc_clock_limit for apu
- Fix Signed/Unsigned Int Usage Compiler Warning
- Hardcode dtbclk value in bw_params
- Revert inbox0 lock for cursor due to deadlock
- Add 3DLUT DMA broadcast support
- Fix Silence warnings
- export get_power_profile interface for later use
- pg cntl update based on previous asic.
- remove disable_sutter touch pstate debug code
- Refactor DC update checks
- Fix drm_edid leak in amdgpu_dm
- Add Extra SMU Log for dtbclk
- Clamp min DS DCFCLK value to DCN limit
- Update dpia supported configuration
- Multiple DCN42 updates

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Fix drm_edid leak in amdgpu_dm

Alexander Chechik (1):
  drm/amd/display: Fix DCN42 memory clock table using MemClk instead of
    UClk

Charlene Liu (8):
  drm/amd/display: dcn42 don't round up disclk and dppclk
  drm/amd/display: System Hang When System enters to S0i3 w/ iGPU
  drm/amd/display: Add Extra SMU Log for dtbclk
  drm/amd/display: remove disable_sutter touch pstate debug code
  drm/amd/display: pg cntl update based on previous asic.
  drm/amd/display: export get_power_profile interface for later use
  drm/amd/display: remove dc_clock_limit for apu
  drm/amd/display: add dccg FGCG mask init

ChunTao Tso (1):
  drm/amd/display: Agument live + capture with CVT case.

Dillon Varone (2):
  drm/amd/display: Refactor DC update checks
  drm/amd/display: Add 3DLUT DMA broadcast support

Dmytro Laktyushkin (1):
  drm/amd/display: move dcn42 bw_params init

Gaghik Khachatrian (2):
  drm/amd/display: Fix Silence warnings
  drm/amd/display: Fix Signed/Unsigned Int Usage Compiler Warning

Ivan Lipski (2):
  drm/amd/display: Move DPM clk read to clk_mgr_construct in DCN42
  drm/amd/display: Move DPM clk read to clk_mgr_construct in DCN42

Joshua Aberback (1):
  drm/amd/display: Restore full update for tiling change to linear

Matthew Stewart (1):
  drm/amd/display: Hardcode dtbclk value in bw_params

Meenakshikumar Somasundaram (1):
  drm/amd/display: Update dpia supported configuration

Nicholas Kazlauskas (3):
  drm/amd/display: Add MRQ programming for DCN42
  drm/amd/display: Split arbiter programming for DCN42
  drm/amd/display: Revert inbox0 lock for cursor due to deadlock

Relja Vojvodic (1):
  drm/amd/display: Rework YCbCr422 DSC policy

Roman Li (4):
  drm/amd/display: Add get_default_tiling_info for dcn42
  drm/amd/display: Add missing dcn42 hubbub function pointers
  drm/amd/display: Clamp min DS DCFCLK value to DCN limit
  drm/amd/display: Update underflow detection for DCN42

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.375

Wayne Lin (1):
  drm/amd/display: Remove unnecessary completion flag for secure display

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   7 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 263 ++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 500 +++++++-----------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  30 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  25 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   4 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |   1 +
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |   2 +-
 .../dc/dml2_0/dml2_translation_helper.c       |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   2 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   2 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   2 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |  63 ++-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  35 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |   6 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 108 ++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 .../drm/amd/display/dc/link/link_detection.c  |  10 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |   9 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn315/dcn315_resource.c      |   2 +
 .../dc/resource/dcn401/dcn401_resource.c      |   2 +-
 .../dc/resource/dcn401/dcn401_resource.h      |   1 +
 .../dc/resource/dcn42/dcn42_resource.c        |   5 +-
 .../dc/resource/dcn42/dcn42_resource.h        |   3 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |   8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   7 +-
 .../amd/display/modules/color/color_gamma.c   |   2 +
 .../amd/display/modules/freesync/freesync.c   |   6 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   1 +
 .../include/asic_reg/dcn/dcn_4_2_0_offset.h   |   6 +
 41 files changed, 588 insertions(+), 578 deletions(-)

-- 
2.43.0

