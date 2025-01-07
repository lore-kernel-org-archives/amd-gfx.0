Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C936E77197
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2025 15:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4B010E70C;
	Tue,  7 Jan 2025 15:29:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mpGBQeqP";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5EAA10E1AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2025 15:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlvCtBEAQZ8Zk7lJ1ZxvWCPjx4LRo0GM7nxfjbd4vFhZwyTjDZ31ky7bOxksvqakKqFoL022gnBrq3kAhhhumam5tzeJxEJRlLqi8GjkjmquDNJSu7NGBAXHR3Z9Ogc1qEP3nhC3X/XEboJ7/nyrNcIVSvxGQVMs0wTcOWYMEnPWG0lTaWucPU4EcROfm32PyeQxosBcwxMz+IANdq1nkbcGuLtZh3coS1ZD4qKn16ZNs+Ln2ED9WW4W/mvTSi+i11xt3oe0srAX0JZQQESzk0OShByggcslFwSw8Tdzvp9cWKd2Rm+1oTith8iGOmlSyjHJ4E559TCmp4Hftv7ejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nwMU0SyupjUd5H0k4+nnseaP7eFceFpMB9USvN64GY=;
 b=X3+18trsovC6i33CYz0vdGd6hylfrTgdL/8q4AWWs7t+37FRe2tcgmvGHo9XulFR16bXjFhXocUXc7hFwywDhW7xjCsB3jMbWUXshaL3MFKRj7YGCJlme8xc3qMbTL/KgrHMLRI1rCHUqxLZ0mKG+X+6viqp2L2sixxYKI72elpYDJI1O6x1AugeRLUUvDyRQks5nkePgNbOsEH0Bu7iPnCzeW3zjmF6eqLoynounC/BCeFbnzeY6OIGORqx/WKrSK9RKTbvRv4KXBdEJp5X1QVTofn4+u8qfFhELQ/62qhxhfd6N/rw5W5LJhsS55QkaXwfIEroclOQJ38uLvM5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nwMU0SyupjUd5H0k4+nnseaP7eFceFpMB9USvN64GY=;
 b=mpGBQeqP14YRHHlMU0aKoflxXANsQH25bPZ6OAEdyg6ehWVbGdJAtc7SlT9uudk4ppw8bEh9PYtMFofFJOJi14Aiwc+rbe3GxteZUwCOPEBuX6oZLMZKcm4FRIXgzT4K45io2JK9EWE9efTOkxRWtDYA7IKFc1qmOzZCbFtI0tk=
Received: from SJ0PR13CA0215.namprd13.prod.outlook.com (2603:10b6:a03:2c1::10)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 15:29:04 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::82) by SJ0PR13CA0215.outlook.office365.com
 (2603:10b6:a03:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 15:29:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 15:29:03 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:02 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 09:29:02 -0600
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 7 Jan 2025 09:28:59 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 00/24] DC Patches Jan 13 2025
Date: Tue, 7 Jan 2025 23:28:31 +0800
Message-ID: <20250107152855.2953302-1-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6172e0-9cc0-4993-9e57-08dd2f300460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|30052699003|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j14osf5OH0Hv6I10eQ2OL/l86UxclTSYDKj3+0grbzDixn2UV7iwL0tWym76?=
 =?us-ascii?Q?+6Sfxt2ckuLTJ+wwwLW8lV5dNsco2/ozgtpA594qzMjboq/aZjUxjTHQj9jy?=
 =?us-ascii?Q?Vi+GGPOJHoR8smv3bl0PSUxRiYXFUQqx30LX4o7oHrf+wRJ3L3c6QCxF41D8?=
 =?us-ascii?Q?UfVAgIooYCcJ5XwDBBrNSt6W4k+VcsGA2SS1iaePwIAPg2vpAGBQn5PeQd8I?=
 =?us-ascii?Q?qQgQ7kdpC2KaP8S2AQRVQ5zWALYUclBqQ5BKFJ57l7tl0XqLtweDmrxb1SU3?=
 =?us-ascii?Q?YLFBr3wG6rcZdbBrQG17Cdi0klZwSwvt+pL2pWhxoNmll6ew3kOpS2m5PbJ9?=
 =?us-ascii?Q?EUtxnt9ata4zOjZXBwgOdchdfA+qEvnDJW9svmUkLxS3WjI4zmpSMQhqQRQq?=
 =?us-ascii?Q?GCIJfrMb2KxJTRHjpf+vB5Ylpw8VuMW9DLwMRdPmAI3XAW0/Fl9Qt10G/tGB?=
 =?us-ascii?Q?q6r7579KKO3tIt1E/FToY2NijMvCCOpw43EkN307Y03dcaI1mCQX4dmHsmBq?=
 =?us-ascii?Q?Y9W0R7w7TRqtiyyyMBtfVo819pMASgxO9AHYHnkSF5O9NyNGDTt7bzWtSnUA?=
 =?us-ascii?Q?nJ3tLRg7J7iCSk9gOoJk6zuK/dP8ATyhz+7ZLnjxzhjpXx6GHjQ+NlRQoRUL?=
 =?us-ascii?Q?uuFCtPTJAWSM/ItfxiMpMp3MG3UBuMSH8o1+KnoxcCMEgJq3A7ZlBOcOUjUm?=
 =?us-ascii?Q?nIEHcOTUPMDMdR/lqFoYWKlT5y14mFCeA63uJmJ9RPARqyX4rwaOuLY3AlS9?=
 =?us-ascii?Q?JMfXsP2Sio6AWRBsc5JSKXkSLXPLVcK6d5VzfMplplVD7dnDYKA2lqehZ+IU?=
 =?us-ascii?Q?oVXqpS3we39D6jtd9w7X7M3rLHfygvvDPkcVWIFW2+/EI35fzAx6VGpxpUyn?=
 =?us-ascii?Q?bs3iK0Z75jKBtcbRn9C3kBwsui4QzaVAa6pL8F8ZXzF2AYZbsJIcwwwu7sxj?=
 =?us-ascii?Q?tDCi/zGFf3UhuVmDaU3V8YOO/kdnwJboj4r5ZA7ONQpzsWXp7tfDiDuuj0ji?=
 =?us-ascii?Q?EI+/LtaO8B1+oTMkUPUl+05bcOji1YBnMsF38pGgA6LqJCviBbmaRSnGwPi+?=
 =?us-ascii?Q?fmRzE6EndiJT4GVA4ytER/nZROWtTsZ/E483Fc0gam2zFF2XEITVXhyugbxd?=
 =?us-ascii?Q?5yXcUD1MaqWXC7cwXWjVfrj8MkLBhgxm+5eWtxPsLcl2U+j8TA9aw3DaStc8?=
 =?us-ascii?Q?CqpNiwU5ZuD1ULNNlmMylPeh4YpYHQvrt1zxkpr5CvJz4M0hn0kbvwZMQXUM?=
 =?us-ascii?Q?57+sRS+VHElUwKKk+tBHWeDI7TTSolQQUzqga/8FaQFb6GZl506Yc1ZGxvWb?=
 =?us-ascii?Q?qKa66L/izVw7gJ5x5zrIuTFI3lYDXjsiBGx0eQCZslyBcK97MXt+azcK7Ubl?=
 =?us-ascii?Q?gXiLJGH+/P1cdwgQ4Xakr1ZJJmJBz4Z7i9W63ErpAfIqWddzrcoUhSP2IgkQ?=
 =?us-ascii?Q?Opx/EIjPJZ1eKP/H6EhQDR2aa2gh1nneFlojH5MSugLtP+qx4m97mSWqkraf?=
 =?us-ascii?Q?/qhpCV0e0Y2LG6o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(30052699003)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 15:29:03.4229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6172e0-9cc0-4993-9e57-08dd2f300460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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

- Add some feature for secure display
- Add replay desync error count tracking and reset
- Update chip_cap defines and usage
- Remove unnecessary eDP power down
- Fix some stuttering/corruption issue on PSR panel
- Cleanup and refactoring DML2.1

Cc: Daniel Wheeler <daniel.wheeler@amd.com>


Alex Hung (1):
  drm/amd/display: Initialize denominator defaults to 1

Austin Zheng (1):
  drm/amd/display: Apply DML21 Patches

Charlene Liu (1):
  drm/amd/display: avoid reset DTBCLK at clock init

Dennis Chan (1):
  drm/amd/display: Revised for Replay Pseudo vblank control

Dillon Varone (1):
  drm/amd/display: Add SMU interface to get UMC count for dcn401

Gabe Teeger (1):
  drm/amd/display: Limit Scaling Ratio on DCN3.01

Jack Chang (1):
  drm/amd/display: Add replay desync error count tracking and reset
    functionality

Karthi Kandasamy (1):
  drm/amd/display: Remove unused read_ono_state function from Hwss
    module

Leo Li (2):
  drm/amd/display: Do not wait for PSR disable on vbl enable
  drm/amd/display: Do not elevate mem_type change to full update

Michael Strauss (1):
  drm/amd/display: Update chip_cap defines and usage

Nicholas Susanto (1):
  Revert "drm/amd/display: Enable urgent latency adjustments for DCN35"

Peichen Huang (1):
  drm/amd/display: improve dpia pre-train

Rafal Ostrowski (1):
  drm/amd/display: DML2.1 Post-Si Cleanup

Robin Chen (1):
  drm/amd/display: Add a new flag for replay low hz

Ryan Seto (1):
  drm/amd/display: 3.2.316

Sung Lee (1):
  drm/amd/display: Log Hard Min Clocks and Phantom Pipe Status

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.248.0

Tom Chung (1):
  drm/amd/display: Use HW lock mgr for PSR1

Wayne Lin (4):
  drm/amd/display: Validate mdoe under MST LCT=1 case as well
  drm/amd/display: Reduce accessing remote DPCD overhead
  drm/amd/display: Add support to configure CRC window on specific CRC
    instance
  drm/amd/display: Extend secure display to support DisplayCRC mode

Yiling Chen (1):
  drm/amd/display: Remove unnecessary eDP power down

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  33 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   2 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  83 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  48 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  35 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   3 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   9 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  18 +-
 .../amd/display/dc/clk_mgr/dcn401/dalsmc.h    |   4 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |  25 +
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   |  14 +
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  16 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   3 +-
 .../dc/dce110/dce110_timing_generator.c       | 169 ++--
 .../dc/dce120/dce120_timing_generator.c       |  90 +-
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |   5 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   4 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |  86 +-
 .../dc/dml2/dml21/dml21_translation_helper.h  |   2 -
 .../amd/display/dc/dml2/dml21/dml21_utils.c   | 129 +--
 .../amd/display/dc/dml2/dml21/dml21_utils.h   |   8 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   8 -
 .../dml21/inc/bounding_boxes/dcn3_soc_bb.h    | 401 ---------
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 111 ++-
 .../src/dml2_core/dml2_core_shared_types.h    |   6 +-
 .../dml21/src/dml2_core/dml2_core_utils.c     |   2 +-
 .../dml2/dml21/src/dml2_pmo/dml2_pmo_dcn3.c   |   6 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  10 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   1 -
 .../dml2/dml21/src/dml2_top/dml2_top_legacy.c |   6 +
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.c  |   1 +
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.h  |   1 +
 .../src/inc/dml2_internal_shared_types.h      |   2 -
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  14 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  92 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  35 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 257 +++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  17 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   4 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 831 ++++++++++++++++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  11 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  10 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  12 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   3 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  11 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   3 +
 .../display/dc/link/accessories/link_dp_cts.c |   4 +-
 .../hwss/link_hwss_dio_fixed_vs_pe_retimer.c  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  23 +-
 .../drm/amd/display/dc/link/link_factory.c    |   2 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |   2 +-
 .../dc/link/protocols/link_dp_capability.c    |  10 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   3 +
 .../display/dc/link/protocols/link_dp_phy.c   |   2 +-
 .../dc/link/protocols/link_dp_training.c      |   4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |  87 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 101 ++-
 .../dc/resource/dcn10/dcn10_resource.c        |   8 +-
 .../dc/resource/dcn10/dcn10_resource.h        |   1 +
 .../dc/resource/dcn20/dcn20_resource.c        |   3 +-
 .../dc/resource/dcn201/dcn201_resource.c      |   3 +-
 .../dc/resource/dcn21/dcn21_resource.c        |   1 +
 .../dc/resource/dcn30/dcn30_resource.c        |   1 +
 .../dc/resource/dcn301/dcn301_resource.c      |  11 +-
 .../dc/resource/dcn302/dcn302_resource.c      |   1 +
 .../dc/resource/dcn303/dcn303_resource.c      |   1 +
 .../dc/resource/dcn31/dcn31_resource.c        |   1 +
 .../dc/resource/dcn314/dcn314_resource.c      |   1 +
 .../dc/resource/dcn315/dcn315_resource.c      |   1 +
 .../dc/resource/dcn316/dcn316_resource.c      |   1 +
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn321/dcn321_resource.c      |   1 +
 .../dc/resource/dcn35/dcn35_resource.c        |   1 +
 .../dc/resource/dcn351/dcn351_resource.c      |   1 +
 .../dc/resource/dcn401/dcn401_resource.c      |  54 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  15 +-
 .../amd/display/modules/power/power_helpers.c |   9 +-
 .../amd/display/modules/power/power_helpers.h |   3 +-
 88 files changed, 1891 insertions(+), 1184 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/bounding_boxes/dcn3_soc_bb.h

-- 
2.34.1

