Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5D7EE57C1
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Sep 2024 16:21:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD79910EA47;
	Wed, 11 Sep 2024 16:21:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RCBMmUjT";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7055710EA47
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Sep 2024 16:21:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqNOSR/Zjyc5RV3aKBaq4LJhDOg7KsT8ZHOOOZ2C5Pa/kEUqM6Diy62AE+1G4L1HwsUNBvu/gp/hcGV1A0W0gJOAEgqoS8uRdVcn03flmEAiXfQAEPwGFyVug1mWIlfTQrTOmIVTT3KyEHoMnj9JpqvLvmgFUrQXrk+RUxIvEA2MaLuEVLzYZ+m+2K7VP3E6IyXvLbjEGJIi/NC46nZsfB832sFP99KNiJYO9ZM/ohPf5rNiS6rAPOOX0ayC2ocWGohEWu9YBhF+ZFP4P3pbTrFjA36uRZq2Q/j1sl6ezfOezUkl0IK4mP/kITHuy9cwRApklu+b2yxYvihrpulNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzgSBVoXnWb7VwdDkTWH87aGigDb0pN+QxjgEOsqnhs=;
 b=BST4fg2Kj61cvgKIptMbow4TTMBv4Yrz0czSWbemct/Pl4DkrKnIznUDH+ymgtWlsXIkApcoVs5JkwyNeEhFeFr6rYM2uIpafX4bxRfKX6nIK9FMYIb3CQ0/v4RehE4kJ35E4unTv6Qw9VDSybLJ1R78F5myL3vBw54LgcnoUEuEwIPykcm7e+J9bymG8EWf0IKFk2GjnNQXi+PJfqBOpFy/+kynd8GAkcP/hdsQyMWDyvvcphgKzqiE1byjoJG5bcgsUG6EwRoDvdUiCeUYCsk4IbdyQN5SXH0sBPer1bh5JNFXpDK6I32d40wPqTyyGLe+c1uSjDkmi1Evu1vBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzgSBVoXnWb7VwdDkTWH87aGigDb0pN+QxjgEOsqnhs=;
 b=RCBMmUjTRjT46NDd6FOo+nntgdNwKVdzfWIdgkc6GPoAmWgQosi+qx4gfNa/SDr6V1/Idv67bnm6yRGfJyvBMUVCNjUmCBheqbAImNkPOJnvb5xYVsvyRWbwq+EPYR+TgkofH4e21Uh7aOkL8pcejsNxalATG7tdvV/c2A9T6sw=
Received: from BL1P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::6)
 by CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 16:21:36 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::6) by BL1P221CA0012.outlook.office365.com
 (2603:10b6:208:2c5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 16:21:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 16:21:35 +0000
Received: from shire.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 11:21:33 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 00/23] DC Patches Sept 11, 2024
Date: Wed, 11 Sep 2024 10:20:42 -0600
Message-ID: <20240911162105.3567133-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e19951d-9477-4ff3-7cd5-08dcd27dcea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DDYgQtl9MMFDHxzhgICYT5b1sCIkctMNQOeybTeKgMnBYd/8kSuqL0xiMdPs?=
 =?us-ascii?Q?9+BWiDONubqk0DT3NUvfb5e8iPE1RPN5PWDwjYvmCL2qfF/T9voYqOt6Am7l?=
 =?us-ascii?Q?hLQ5gJfj9SkBXQsE6olMVeF69n6XCyWRtoy4nvhv7X7DOxmbjKEVm3rRhV9S?=
 =?us-ascii?Q?VCqlcxDD7SrK9jJPWv4sWBju4RNeCCsQqeTiSzKo0+vciw+hejFQO7PfHoxG?=
 =?us-ascii?Q?28LVH7Qr2mae/vounkK8kcCZv2IwYOu3bD/SL7oipXnN095gtoJorQXPRMsX?=
 =?us-ascii?Q?y3CL8W33FK3NVl6u/UEFPoL6qiSOYbSzjW2ygrnD1kP6zxfE+3WE344iTShu?=
 =?us-ascii?Q?hKWQLMB1H0unA5StjpaYGdzoZSye0FWNnK+gFlB06S69/yfrWybN1mbNgD8O?=
 =?us-ascii?Q?PuwuXvHzm9BWL07WSjT6Vyn2NnqSkm8PtqsCtrUbYqRCvzwFTUHCKT1sEs+7?=
 =?us-ascii?Q?sIRaKTdjLr9j/innqzhxZH/gn6UMMS4Wlmq2pcWf0qLOzzCSrqTITN3dfz3f?=
 =?us-ascii?Q?nUsMlkAAqXhGyjrhZUVNUraG9dhbAwo/UTvj0KRVAnP5k6p5qV7oOueMtUia?=
 =?us-ascii?Q?5GPuXWcYXmPa6Z0i0jTQCB9rxNivHhIuPIX4X6xzaAOipotuBiXkHXA8ZKzJ?=
 =?us-ascii?Q?xpCCkp+oXfilgJo6dD8u/tT9HZAuXP2B9wgyX4oDvt3nIteOI9U9OHLyKTeC?=
 =?us-ascii?Q?ytxDXC5vqiSbH4JYfjz8FBhh8ovoOT66Bzu1YIiFd8/RTY7La77YVTCDRBFK?=
 =?us-ascii?Q?DOi6OdHMi/5GASeSNpKnhoeHrJbp7rfh8o4uT+F3MbnwHZzbSXYM8vd/7WTD?=
 =?us-ascii?Q?N5B+vjBzpvA++D/oZ74XIMv9zNtKBq69HvMF5VVvh04u92xdH4iYNgMNkuoW?=
 =?us-ascii?Q?X7E4U+y+eicL5dHaOLNKYozZrzn4SdZcJx6K6sal4tJp86MRQTDj19TlpaJT?=
 =?us-ascii?Q?tGnyTxc/+WVxf1lfwYo+KQO5t+Z/y0xSLmBVYBhLPMwMVRiKQWlXiwOFA9nH?=
 =?us-ascii?Q?cqNkex2saarbOYuiM9iNWRZ0jXnchqr2nhS8tw+1txWznh/q4kxBDY2g/93I?=
 =?us-ascii?Q?HaXMS8/2L3hQzwtbxXYA7u4LtvOSBiRz6ZdNMO0CChDE+t5lJpKZEhQ3ncgI?=
 =?us-ascii?Q?VmNodMI91tj51Ja9x6SuPGUTWSLDP7osNAi8BAudmtXjY/7YcJCvARtF7VXE?=
 =?us-ascii?Q?dH8Vr4Xu6HULf/cteH0I7TdkEzwNBbrwVpGb/h6D5uUVMy0GopCa5mReCUte?=
 =?us-ascii?Q?7noL16ro7kUrNv1t5OsT+9dKAY6ih/Z+29wsdKl7Smdj8Vr8QVIOGf/IZZGx?=
 =?us-ascii?Q?Yy4xXBqcxB0XsV4anTtg7uiht4gHYIzcVSsjYOAmhkVOlrPASrLybqth/LJf?=
 =?us-ascii?Q?3+EV0BEYH/FZxnRLvWKluJ8ZC+5zzNM2C3aoc93JgU8NMLQ8GJ+q8tFRQlfs?=
 =?us-ascii?Q?glor6Cq5uvzuajA5o0eG4HXtl3QbjDgG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 16:21:35.8552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e19951d-9477-4ff3-7cd5-08dcd27dcea3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909
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

- Fixes on DCN35, DCN401 and IPS
- Enhancements in DMUB and DSC
- Misc fixes for Coverity errors

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Check null pointer before dereferencing se
  drm/amd/display: Remove always-false branches

Aric Cyr (2):
  drm/amd/display: 3.2.300
  drm/amd/display: 3.2.301

Aurabindo Pillai (1):
  drm/amd/display: Fix underflow when setting underscan on DCN401

Charlene Liu (2):
  drm/amd/display: Use full update for swizzle mode change
  drm/amd/display: Clear cached watermark after resume

Daniel Sa (1):
  drm/amd/display: Emulate Display Hotplug Hang

Dillon Varone (1):
  drm/amd/display: Block timing sync for different output formats in pmo

Leo Ma (1):
  drm/amd/display: Add HDMI DSC native YCbCr422 support

Martin Tsai (1):
  drm/amd/display: Clean up dsc blocks in accelerated mode

Nicholas Kazlauskas (1):
  drm/amd/display: Block dynamic IPS2 on DCN35 for incompatible FW
    versions

Peichen Huang (1):
  drm/amd/display: Restructure dpia link training

Relja Vojvodic (1):
  drm/amd/display: Add fullscreen only sharpening policy

Robin Chen (1):
  drm/amd/display: Round calculated vtotal

Roman Li (2):
  drm/amd/display: Add dmub hpd sense callback
  drm/amd/display: Update IPS default mode for DCN35/DCN351

Ryan Seto (1):
  drm/amd/display: Implement new DPCD register handling

Samson Tam (2):
  drm/amd/display: Use SDR white level to calculate matrix coefficients
  drm/amd/display: Add debug options to change sharpen policies

Sung Joon Kim (1):
  drm/amd/display: Disable SYMCLK32_LE root clock gating

Yihan Zhu (1):
  drm/amd/display: Enable DML2 override_det_buffer_size_kbytes

Zhikai Zhai (1):
  drm/amd/display: Skip to enable dsc if it has been off

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 70 +++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  4 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  9 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  6 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 41 ++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           | 14 ++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 12 +++
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |  4 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c | 14 ++-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     |  3 -
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |  3 -
 .../dc/dml/dcn31/display_mode_vba_31.c        |  9 --
 .../dc/dml2/dml21/dml21_translation_helper.c  |  4 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  8 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   | 15 ++--
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |  1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 50 +++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 14 +++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 13 +++
 .../amd/display/dc/link/hwss/link_hwss_dpia.c | 31 ++++++-
 .../drm/amd/display/dc/link/link_validation.c |  7 ++
 .../dc/link/protocols/link_dp_capability.c    |  5 ++
 .../dc/link/protocols/link_dp_training.c      | 80 +++++++++++++++--
 .../dc/link/protocols/link_dp_training.h      | 16 +++-
 .../link/protocols/link_dp_training_8b_10b.c  | 21 +++--
 .../dc/link/protocols/link_dp_training_dpia.c | 64 ++++++++------
 .../dc/link/protocols/link_dp_training_dpia.h | 19 +++++
 .../dc/resource/dcn35/dcn35_resource.c        |  1 +
 .../dc/resource/dcn351/dcn351_resource.c      |  3 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 54 ++++++++----
 .../display/dc/spl/dc_spl_isharp_filters.c    | 85 +++++++++++++++++--
 .../display/dc/spl/dc_spl_isharp_filters.h    |  9 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h | 15 +++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 25 +++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  1 +
 .../amd/display/modules/freesync/freesync.c   |  2 +-
 38 files changed, 588 insertions(+), 147 deletions(-)

-- 
2.34.1

