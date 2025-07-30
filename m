Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62D9C83F26
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 19:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B3F10E220;
	Wed, 30 Jul 2025 19:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n3IglhTJ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E970D10E220
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 19:00:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5xpnhlXmE9SBTy3WHX3iETPJGH+n9Y1j0mOTaIE4k8wdf7j5yIRfijQcOa7JfWVeiS6Tx3JOiwkzzdSEv54/ElRUfVlq90Qye0U8HBA6mazU910ntCuvf2NbVw+NZ7fnbwRxuOdM0pkVlyFV2hzZ9KvYjxt+6fW+EfW2r4KpxMuk+DSJII2xYmHiwAxAr9JvzslDBhbbqP2oISUxOLyoD88NC5DTdEzqFjhzmVCBaGOR5FeEr3KHIl7UZaBeJrhZFgNRBKm+Ry5wDdFh3pn/KwIBXBCPSRfa1RPzM/eaX0t6N5BDKt0RhDwFXK5kMT8+rB1kOdZjcteJKwZrjF/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxNlB3YDU7FqWHCLkON79wBva7g0/nUFZfryyhUly+Y=;
 b=DOOGCrKxGm67G65G6iuzw9hAW3N4R/GiuQVBP339ASBeSY0hYQNhD4SErck+Ef4CUiuYbRDvOGDYRldcrkqxmbbJmYzuff3GMMgH4GydspCrx0znUaU3Q+KwRI6rYmPQdydJE+8fK/cFbIGu1QVKcc5ZCs7s5HctXoFGV2ESELcE3g65lG7yPGE84lW+AQp3Ix/Gjwh9AkW50rsohCRIoc43wD1q224eGZst+kT/JIwQeV1TdD1TUqcvwVHjiSFl8oPASmJIcc3Dd3+qnpUQqobRnlFwd/pRRoTdfy3S6OkH/5leGXG/jTy74crfL+MHnlt86IJJidIG72P/otccNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxNlB3YDU7FqWHCLkON79wBva7g0/nUFZfryyhUly+Y=;
 b=n3IglhTJ2rb3TorGirmqcKEFM5bbkmXAkDa7gBu0pRS3/HRx3soF2guwTInHx4RpoVBHCx6LX6VTwEilxecxTh4pubhFpxWMg2yVNJVjwcI6nm0E8tfVUFb1ngq96OoUNDxgSC7fzHmty3XL/GrPUN7u50MxWPrunN7psIEa/zg=
Received: from MN2PR22CA0003.namprd22.prod.outlook.com (2603:10b6:208:238::8)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 19:00:43 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:208:238:cafe::a1) by MN2PR22CA0003.outlook.office365.com
 (2603:10b6:208:238::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.11 via Frontend Transport; Wed,
 30 Jul 2025 19:00:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.10 via Frontend Transport; Wed, 30 Jul 2025 19:00:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Jul
 2025 14:00:41 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Jul 2025 14:00:35 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 00/12] DC Patches July 30, 2025
Date: Wed, 30 Jul 2025 14:58:51 -0400
Message-ID: <20250730185903.1023256-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a14fce-4f92-4cf8-f114-08ddcf9b61e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TVB6vM/DnsGT/Wzp/s7zUlNXNkHHZ1yXhXznQr3Z+MjeasOl4C9AweBkoJZ5?=
 =?us-ascii?Q?ruqH6+2Q+Vwe+MdoQsp1nsGa1v2yYIq1shqFaFKpFAN42zRcREHCmjfDGY+U?=
 =?us-ascii?Q?tu0RhRRhXQXilLCYcWb1ta/LJ1CBgVilvWDTT0fYyjtIB8KkfYrxErB1neZf?=
 =?us-ascii?Q?VCOG1ykL1nZArXBDSih3xSfL40YYKyRFCkP5hsJcFa0RVYA6/ZGvfWhC9g3e?=
 =?us-ascii?Q?bVRsvjTxsCMShhPwyuNy5T1KdE4updJImIoOnXw9gkUyYy1w2EVUYb38uQ2A?=
 =?us-ascii?Q?ouqCbsDH0W+U3t+cRG4qWGkLO2v6GhiLgN8pv9WTipzWPrS6z7QGeo0FTEz2?=
 =?us-ascii?Q?qPP/zY4/xMTDsxCjvXUL6bocD8AvS3lQWepB+k2DSlS2EUQdzph991sR1udJ?=
 =?us-ascii?Q?OKoZsc9F1IHfOJsncSTPo2TblMoXZlINib0MxZmE41xWJyYSMyaCNHptjVkd?=
 =?us-ascii?Q?Uxm8+eW2biLLGS/doIZi+/+NB75pCF7LOTn4S2QQJL4aCfC5VxM2SY9S2Ii6?=
 =?us-ascii?Q?CPBUeI+3Y0HE1KYb204eVRlzPBdEZda78cES3Zr5OyIPMlmqID7XF+Eji4kA?=
 =?us-ascii?Q?AAzPBhukzuthAaaA/3HtcwDG5L7uHCJ4omtjdobjhN4SJCxzCRfaoCIpzGQp?=
 =?us-ascii?Q?mUyaxZOHhmPNiiTwDKZQfCAQGUugKu+JaFhY/1k0b9meFhsIeBBq4uKO8Hjx?=
 =?us-ascii?Q?WwcgPydVwATH3WugGZZV/O4k0zdeGeNOAt2gxB+N4Bo0GzlS1UWxNjbiqSyR?=
 =?us-ascii?Q?3zS2WsxVxj4o7d/ZhEgXa31LkcWmAvX9HwEWdrsaZJQur4kS/JRq0PeF3y0j?=
 =?us-ascii?Q?j25vYxoLLN60u8KAL4TnYzzNAw+XqvbrB26Lb+1KLxAZIB6ZImTsucnSvzzP?=
 =?us-ascii?Q?TUAGwbrUIMxSEnPOU26+z5XQdoiSZlWl1XQ1hqOMCWLbmi5/SB7AZGfHYcm4?=
 =?us-ascii?Q?dpBWDK64BT+xQrBUssqGGq2vU/oa/iUnWZMIyH/BaxSzEW5kx0wWvVMgjfTu?=
 =?us-ascii?Q?BXar0AVRtnGpYc1tOCNaQhZH67xXDOwEirR7oxS3wFKdjK0O5068b7hAt1kH?=
 =?us-ascii?Q?iXX7ia3kbLSwfhbVdWzmchWEwrzV4edktPCxbe8qc4rP0/xGA78Wz6LWs8MK?=
 =?us-ascii?Q?2QUxzVzghYRZKgouqrtHJw1A+LJV3qkKW9ph0Qci9RMzTWsjFObQuMNHV3bt?=
 =?us-ascii?Q?YAItaQYPcPZ8l4eFg6cR8yR8KQX35UnWTc9TKxECNxdRiC8v4DSQb0jDn9ZQ?=
 =?us-ascii?Q?8TrkCWW3XOW4UMHqHPwCWjp/7rU9sOKp08sOSrn0lwYaathX5NvhvyfyezrZ?=
 =?us-ascii?Q?ZEbQpTCAmBPSCGrul5XlaSXs4Ul/c2D+Np1QXkib09PBv6mK8jd3Goz5r2x9?=
 =?us-ascii?Q?VJdC0rHbA3Zfx1Buyxa7R630+w8xdNIGCB3f1ZhhHi0e8XAEBL5FF0rWvew5?=
 =?us-ascii?Q?+MPd9+GfRPEd7kFipDrP0ORdh0k27btxoWlKtZX8u6nPeWlnYAnZEe8TdmtT?=
 =?us-ascii?Q?0SUFRD+f6wi31/ZafCdkHRK9UB+AVAuqO25L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 19:00:42.5059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a14fce-4f92-4cf8-f114-08ddcf9b61e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813
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

* Add interface to log hw state when underflow happens
* Fix hubp programming of 3dlut fast load
* Avoid Read Remote DPCD Many Times
* More liberal vmin/vmax update for freesync
* Fix dmub access race condition
 
Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aurabindo Pillai (2):
  drm/amd/display: fix dmub access race condition
  drm/amd/display: more liberal vmin/vmax update for freesync

Duncan Ma (1):
  drm/amd/display: Adjust AUX-less ALPM setting

Fangzhi Zuo (1):
  drm/amd/display: Avoid Read Remote DPCD Many Times

Jingwen Zhu (1):
  drm/amd/display: limited pll vco w/a v2

Mario Limonciello (1):
  drm/amd/display: Revert "drm/amd/display: Fix AMDGPU_MAX_BL_LEVEL
    value"

Muhammad Ahmed (1):
  drm/amd/display: Adding interface to log hw state when underflow
    happens

Paul Hsieh (1):
  drm/amd/display: update dpp/disp clock from smu clock table

Reza Amini (1):
  drm/amd/display: Fixing hubp programming of 3dlut fast load

Ryan Seto (1):
  drm/amd/display: Toggle for Disable Force Pstate Allow on Disable

Siyang Liu (1):
  drm/amd/display: fix a Null pointer dereference vulnerability

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.344

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 81 ++++++++++++++++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 14 ++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  9 ++-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 16 ++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 37 ++++++---
 drivers/gpu/drm/amd/display/dc/dc.h           | 59 +++++++++++++-
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 20 ++++-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    | 31 +++++++
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |  6 ++
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |  2 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  2 +
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    |  9 ++-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  1 +
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 26 ++++++
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |  8 +-
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    | 15 ++++
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.h    |  6 +-
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  3 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  3 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  | 41 ++++++++++
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |  8 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 63 +++++++++++----
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 48 +++++++++++
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  5 ++
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 36 +++++----
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  4 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  | 21 ++++-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   | 11 +++
 .../link/protocols/link_edp_panel_control.c   |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 +-
 .../dc/resource/dcn401/dcn401_resource.c      |  1 +
 .../dc/resource/dcn401/dcn401_resource.h      |  3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  1 +
 45 files changed, 545 insertions(+), 67 deletions(-)

-- 
2.34.1

