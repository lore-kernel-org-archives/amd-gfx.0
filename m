Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39588C98325
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FB0610F72D;
	Thu, 24 Sep 2026 18:46:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hvwAxf4x";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010071.outbound.protection.outlook.com
 [52.101.193.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 924CE10F720
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJ5OfUa5hXsBlTQ92VjLjJtKpxy7HunRoafK8f7ELiO6kZ4vbgUJ0Ay6v12SSJW296NFY/Solk+19IH82TDMRIgA0MsLpzbJ4eUYdZtc0oj/tr4H91ZpPGzAQmpkEahWgfwM6y7HTxzZ2aVYdygtV7QF1JINNBmNxbF2qNmHuWqaAoJkgNOhyWE+gqR2ONT+RbQmAYCguwzWIUni7EyZm4a2O/DvPVuTqp+xQ03IADjFFv9Kk7vDLk43GQTlq9HRBrPgrS+FuGqym7NK8mixx5NpI8oTEe68c2TbyVb0zdtChXPTLrSy/+TtsNWhOQXuGOFHYDmgCpTKatDDStatXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4G2S6cPDwg4WMamOJ6LFhXzkGbqFse2JFitOpZj4xH4=;
 b=PaXOpG+m8fwOZTnm+Eoy6c78VvS8jXPxTMI/i6ERNgJ6vw5anStqiMoI7Swj8H3bv39/Y/jwyoygBREZrYfN2MLGnZpTItODuBvXehE2RpcGyvecgqYuKSh/y1aAmV6ISdhWNlePD6rNUgjQXRQUhLC+gHvLoDLHBIYk+qvl+PITGnBhvQvNV+3Hrg7AGBDOmmAQcex7htQkeniVBUsxr8IULLEB9ra1KN5a+NeXhNaeBqn8+6ktGeyoVdmCr+hC9/uA8XitBnySACKHnSEvAM3/RvPIt7QiOnW7B/GL8sfL5cuqK0g8VXa07fwg9MOF4Rx5yD75xRX0y6mRAoKrPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4G2S6cPDwg4WMamOJ6LFhXzkGbqFse2JFitOpZj4xH4=;
 b=hvwAxf4xziRItEB/6EcDDGqfbJukl5rk0krmsytAvDtNUmIDmcdXR2u419IrGzeuPDzwDahE4VaKaX/2x2q+R6+FV07V15bhheyyTipC5zLocLg6fw9ZJccoW1gRjh/ny5aGdJGEuVKnG3f5Vga+Fr4N5N0yuPKYKNJp3bNVQ+U=
Received: from SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::10)
 by MW4PR12MB6950.namprd12.prod.outlook.com (2603:10b6:303:207::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 18:46:05 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::7e) by SJ0P220CA0002.outlook.office365.com
 (2603:10b6:a03:41b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:04 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:45:59 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/34] DC Patches September 22th, 2026
Date: Thu, 24 Sep 2026 14:45:13 -0400
Message-ID: <20260924184824.596894-1-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|MW4PR12MB6950:EE_
X-MS-Office365-Filtering-Correlation-Id: 830b7641-3b71-4eb7-4a33-08df1a6c166d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|3023799007|10067099003|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 9kGv+Wyvof96wML6VtNJ8mUUwk4EvBoT4i67/erSw9VrUJhgN1qCkf8x7q63KouOOt8xuVHYXNgpZqCklnq75a8a1LBgoGrXoKC8X+yoE7YERLnqXb9zp2BQni162Q20yxVfxHfh5uNiwVDLQlVH0GPths+LYev8iwbrD/TRdzjNb9Nkcos0lPrvYhPCGfmKh2VcNeboP+oATT5JoEe1hqAXUU1aBIMlKIEOHctE8yAR+JguSDro9c/9Fr3a4ywCQao6TSeL8JUIW33CfJCiGTwfOakh7cQnUdPk1/gcxj+xMyoEXm8mdE1o8pCXZrGiV39GZuqW/MtwTAGEXdB1s2DrLSlf+eYT1EWbbdSNm6ZFUOE9GMBa85pyZgH1E7UhjLKuNXjwi4IzNkWn5EKhHCU0d5doknbSVJM72mcM7eEh0l/HyTn1XJvUasnWCgDIIwNKlQGWoD67AOXkL8bhS6AOHYzPMo2BJ4VFklVNILRWJNUn8yvevNggrw/g0ln1uTXM/kjh4bJBad+qZqscLsBiyZuImp8fKDgj1gRxN3vst4gfB3AopQyR2WXHwTXuH59w4pL2aEX+PTq2+ERYYmvIVW772Lltyn3/4EDTtW/QsZk2xr/I6vncAQJAk7LmgBGVWIds4NA3NaN7yuIipGAlDkCwGhTcRgqU9sqyPKRbeGJnIIdm9LBvCgVHMk+dM/eSC5KqfNSr5nYQD8i+Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(3023799007)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uYZeOC4TYKsAIHRzhgtgSPPBaBomuJOQ9tEfqdq/H4fscW9o9eC+131KtcsDp9mRqlzQU4bmKKvtzT3dtI8btaXdrkjbvgdUDoEZKd9m7ZQPehCN/f0eax/PLtdOslDGsVPXOryzYYZv51f3WqiHJzK2loaEgYnpmHMtiXIu0bZuCl1uC6P3op6eyJh+30+KDX2Lmv1dpyOLS3+BNKpQ6HX4xrccIa3Pythn2ylB5UkM28n8UbiVrB4FywoV2SD8Qek+1F1ArceD31IJrQn3yehlObUd+43Bz3wvol1EWmQC1s14f7/zXyeWgUZz2hl6YQVkcWKIrmhXtl926D5dbfpHktKaltL7cNEv9cWcnFyM1tpXlGD/6c/y0/+ipN+VTsDkj2bz0Qksp/oLmtkI6scwYdxAfrMe+HerTKTSRA6oovjHM7JfKqTEURP1APXs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:04.3628 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830b7641-3b71-4eb7-4a33-08df1a6c166d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6950
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

This DC patchset brings improvements in multiple areas.

- Stabilizes public lifecycle APIs, and adds DCN42/DCN60 support.
- Adds DCN60 clock overrides, DCN42 PMO/P-state support,
  QoS handling for invalid PMFW tables, urgent-watermark overrides,
  and improved self-refresh timing.
- Improve HDMI 2.1 reliability
- Enables DMUB hardware cursor offload and improves cursor/cache behavior.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alvin Lee (3):
  drm/amd/display: Disable gamcor light sleep before gamcor program
  drm/amd/display: Add temporary programming for port control in dc_init
  drm/amd/display: Don't round up cursor width to nearest 64

Ashwin Santhosh (2):
  drm/amd/display: Program OPP formatter for plane-less ODM segments
  drm/amd/display: Promote DC to 3.2.400

Charlene Liu (2):
  drm/amd/display: avoid to write signal specific for tmds
  drm/amd/display: Fix zero dlg_reg write to program_ext_vblank

Cheng, Tony (1):
  drm/amd/display: Keep public DC lifecycle APIs stable beside Core 2

Clay King (1):
  drm/amd/display: adjust floating point format for gamut remap when
    needed

Dillon Varone (2):
  drm/amd/display: Add dcn60 revision specific clock overrides
  drm/amd/display: Fix VTG programming for dcn60

Dmytro Laktyushkin (1):
  drm/amd/display: Enable dcn42 pstate pmo

Dominik Kaszewski (1):
  drm/amd/display: Add missing message to static_assert

Fangzhi Zuo (2):
  drm/amd/display: Serialize HDMI FRL status polling against link detect
  drm/amd/display: Skip HDMI FRL status polling while link is down

Fudongwang (1):
  drm/amd/display: Change default SR z8 exit/enter value

Ilya Bakoulin (1):
  drm/amd/display: Fix HDMI2.2 LT timeout duration

Ivan Lipski (1):
  drm/amd/display: Enable DMUB HW cursor offload

Jackson He (1):
  drm/amd/display: Remove unused copyright notice

Nicholas Kazlauskas (1):
  drm/amd/display: Update default clocks for DCN60 lite3 variant

Ovidiu Bunea (1):
  drm/amd/display: Add urgent watermark override for DCN42

Piotr Maziarz (6):
  drm/amd/display: Flatten OPP_SET_DISP_PATTERN_GENERATOR parameters
  drm/amd/display: Remove OPP_SET_MPCC_DISCONNECT_PENDING
  drm/amd/display: Rename HUBBUB_FORCE_PSTATE_CHANGE_CONTROL wait field
  drm/amd/display: Drop disallow_self_refresh_applied output param
  drm/amd/display: Dispatch HUBBUB_SOFT_RESET through hubbub_funcs
  drm/amd/display: Remove dead self-refresh BLS steps

Ray Wu (2):
  drm/amd/display: map PWM brightness through custom backlight curve
  drm/amd/display: Attach blend mode property for alpha planes

Relja Vojvodic (1):
  drm/amd/display: Block DSC Padding on DP

Tony Cheng (1):
  drm/amd/display: Move struct dtbclk_dto_params to dc_hw_types.h

Wenjing Liu (3):
  drm/amd/display: Synchronize UTM overrides with SMU
  drm/amd/display: Consolidate bandwidth overrides
  drm/amd/display: Fix DCN60 UTM QoS override for invalid PMFW table

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   5 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |  90 +++++++-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  35 +--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  38 +++-
 .../tests/amdgpu_dm_connector_test.c          |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   3 +
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 181 ++++++++++++---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  30 ++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 146 +++----------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 .../drm/amd/display/dc/core2/CMakeLists.txt   |  10 +
 .../gpu/drm/amd/display/dc/core2/dc_core2.c   |  34 +++
 .../gpu/drm/amd/display/dc/core2/dc_core2.h   |  19 ++
 .../drm/amd/display/dc/core2/dc_core2_init.c  |  13 ++
 .../drm/amd/display/dc/core2/dc_core2_init.h  |  10 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 .../display/dc/dc_api_dispatch/CMakeLists.txt |   9 +
 .../amd/display/dc/dc_api_dispatch/api_shim.c |  32 +++
 .../amd/display/dc/dc_api_dispatch/api_shim.h |  19 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   9 +
 .../gpu/drm/amd/display/dc/dc_memory_pool.c   |  10 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   4 +-
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   |   2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |  22 ++
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |  10 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |   2 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |   3 +
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c   | 124 +++++++++++
 .../dc/gpio/dcn42/hw_translate_dcn42.c.orig   | 206 ------------------
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   1 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |  42 ++--
 .../display/dc/hubbub/dcn42/dcn42_hubbub.h    |   7 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |   9 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |   5 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  10 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  50 ++++-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |   5 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  51 +----
 .../amd/display/dc/inc/dc_core_interface.h    |  31 +++
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |   9 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   9 -
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   2 +
 .../amd/display/dc/link/protocols/link_ddc.c  |   8 +-
 .../amd/display/dc/link/protocols/link_ddc.h  |   1 +
 .../display/dc/link/protocols/link_hdmi_frl.c |  58 ++---
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |   5 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.h  |   3 +-
 .../amd/display/dc/optc/dcn60/dcn60_optc.c    |  83 ++++++-
 .../dc/resource/dcn42b/dcn42b_resource.c      |   2 +
 .../dc/resource/dcn60/dcn60_resource.c        |   2 +
 .../drm/amd/display/dc/sspl/spl_os_types.h    |   1 -
 57 files changed, 965 insertions(+), 532 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/core2/dc_core2_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/CMakeLists.txt
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_api_dispatch/api_shim.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_cm.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn42/hw_translate_dcn42.c.orig
 create mode 100644 drivers/gpu/drm/amd/display/dc/inc/dc_core_interface.h

-- 
2.53.0

