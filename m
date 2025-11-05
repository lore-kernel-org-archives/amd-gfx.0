Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F0FCCFA19
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 15:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D3910E2CD;
	Wed,  5 Nov 2025 15:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T5TWUjiF";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011022.outbound.protection.outlook.com
 [40.93.194.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F0DB10E2AC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 15:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt0LFoRU9HflokTXHXEPGO5kALlMBXIY1ARp/9k8XZU+NcupdKLRNbHxogaD2LLfWyVjrDgx8KddYayGzsRjxh9e5fSMxLNRyGSL6GtgjCgDlepvOf/Lxsp3JlHf1Smwwbha4uRGV8N9iGx0lfM6E9cEyExnk06vHDCXwBWLUWZ1pNBY6U5Ycf1mERFl6ew/6Z6+gebZQyhiGroFkla2nhpO9mXzO62aXeWu1gFDnZ3L5e1anecZ8di8A36kZ3OJqlTujGL1Z422MhlViRkJ8RyLSjFGeUOwtcHZhvLlB+aabitMz7FIOoJulVdpeVq5omtc8GWtRlsyrVuUweljPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW9ffgo105PVz4Y1F0s2Wxd5viawGRU8rtc8ZBdm7Pw=;
 b=o6HZj/V5XK1M2IgmvPwnSV+jbqAG9hl5YU5nDFlJH4Cy0DNtjsCDonZ0QUTUjAmprEj+BmS4xAo3ni9Fwz4gNtQP6lU8L7tBfIgXadI5ZoXCyIoQxkkRj7wlU1Y9DLG7HqUa3Bz3ddcwyCBv7CAQ711PZHM2hNV78f/YvPlY1IAqhqmpbf7vc1lauKnyF/42pQSUcGCHizkmHCLQUJRl58QtwzE2/sgNWghVSwvWgj6X8cDfYDCQBGvIhMiNL/4u1zQttnbA340JhoqqB+zS2U+k+Ka7gSdRjVZfKwkUo3HtTBpa2HNeUhoM+VzBhaj7Z7R6T4vc0vXB28HcUU0pgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW9ffgo105PVz4Y1F0s2Wxd5viawGRU8rtc8ZBdm7Pw=;
 b=T5TWUjiF4U/0Q7MxauBiGuuZBq6nhQ4y8nhz3cdZ8gGi1dX+2500UG6otMr3zw2EsmgJO/eS41mO+ObVa/C5vdO9CkSQR9Fa7j4MDi851PQW//9aeTYbbd6M5/jA5DFfp6krpODP7R0kBB6j5MyvDGBDtTa+T5hh+8M7EiCelHc=
Received: from BY5PR17CA0028.namprd17.prod.outlook.com (2603:10b6:a03:1b8::41)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 15:40:52 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::1e) by BY5PR17CA0028.outlook.office365.com
 (2603:10b6:a03:1b8::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 15:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Wed, 5 Nov 2025 15:40:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 5 Nov
 2025 07:40:51 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Nov
 2025 09:40:50 -0600
Received: from jzuo-laptop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 5 Nov 2025 07:40:45 -0800
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 00/13] DC Patches November 03, 2025
Date: Wed, 5 Nov 2025 10:36:15 -0500
Message-ID: <20251105154035.883188-1-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: d48537b1-52d5-4b35-2f39-08de1c81b37c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vIV2n1tp+8QKdbWzoRJNBxHKvgqfiYlb6pjQII6iwlPSUDZ7dg72kb05q+59?=
 =?us-ascii?Q?nHMNrUWmmK4tEPqhQpD9PV9V4cGYPjVZj9eA2r7+JUD542XGkreeV24M8ZK4?=
 =?us-ascii?Q?dqJyk24uRsZcSFkcMSbRmJ4X54JdyzFc1eIPo8VPqDTjVnk9UwNn6rwkOHUJ?=
 =?us-ascii?Q?JaZoVcBp+r9nB7NOwREFjuPhuK7Y40r9oQC6GnL27d1t+j3GQoclTGL9xW0T?=
 =?us-ascii?Q?6kydmBsWYlAC4CZbnfNJJ374MosZ2wFWVEqv9mxL9wEH5rzFW1UDHZowUPer?=
 =?us-ascii?Q?dopKdKyCFkAAC6a+ft9O05r1PspOMl9YDiKZAARLq5P0FO9ArVxZBy81VfZw?=
 =?us-ascii?Q?apLQoTXAAoLE/izKdmmDIEAxqkWGITwfNj8XzBR+SPlbtDP4K7AZOJ7gwE12?=
 =?us-ascii?Q?aPI4YCbS6vt6Baj2fN1sPigeeZAUHRL3geywuNXZFapzwHjM/WJB72Bym/eG?=
 =?us-ascii?Q?YIhp8sBHqdnEcsvni7s/YmCC/drliohXEreSLfhMMep+QeNQKXdVGihF/ZjI?=
 =?us-ascii?Q?Ko19vsGgO3y7hmxu0DSixGgDSabKP3WzP0yPxp1fMhgpGrJxgc4XnrUBDtaB?=
 =?us-ascii?Q?S1sMnQIq9GTBfZ6UpD4141508G7hxdIGUbcTqAR+7aYFHXdEisYIkdIO2tjw?=
 =?us-ascii?Q?ulJ7LZb4U59ElSYXInJTpSy5utiGEN2tpkbYgWCEoHKFTyI3aRgq/jQxkGC5?=
 =?us-ascii?Q?uQhCUpajkxGar54A0+5ir7qyg4uBzAfiQzTWP8zLdcOsS1Rtmw9rG9NDJtIY?=
 =?us-ascii?Q?yMbXBNRGG1/GupKMKjoWozD6IzN1kddFsG/XOK+sL1oy2guARmjMlj4L5kXm?=
 =?us-ascii?Q?OBpybjtvO6LCVyyg1y0tFjxjMGcVWVU60h6A8FqYFzPi/f2IBU/zYeqrI9LT?=
 =?us-ascii?Q?+DS+2OseOUsefQriUbnZZoWMBRnlvTVa85u7uurhGHGavP0FqXxTCYvVflXe?=
 =?us-ascii?Q?yNX8J/EFvhaBMFZrdlJscGEKBYoUpjPKxpecYVmh0EVWaeBKRKPLxrw+Cfr6?=
 =?us-ascii?Q?pUTmFYY75aMxhZANtd/L+ecDgJtir4NytDopKxxguvHYDsAyK6MAGkN5f4VO?=
 =?us-ascii?Q?cv/NIPvnGWd7U4IDU87GhiFN3YTeqGuzYB052V8XqjYpRGFuYZxzbp+8IVza?=
 =?us-ascii?Q?2cofjovNKHKXrMsZqNReXqGzYt+VW/ivtW1oIUmFXuTuLlz7v/e9H7JISLiU?=
 =?us-ascii?Q?X4ohMszyIQ5prbJVlnLyV6tAdwGBItXXVNuF/BoQaRBoQgGbVW5jqPmbuboc?=
 =?us-ascii?Q?wCInykGw8NP0l+NJJfnMicxpnVyeGZUFI2z0VWBlySvUeFcNgBvEEfgLByI2?=
 =?us-ascii?Q?kNmAbn1sDPmarlmsqszfUkZ3jCwaRRTvPjPUV3OpBgCDyiCSqQMBXH7jgrXr?=
 =?us-ascii?Q?dA77q76TA+pFD1zl9gasEim6p7A9fVGFsUGADqbOxwpceLee8lA2Zb35+cS+?=
 =?us-ascii?Q?hdd5HK3xdIls1Y/l5OQAY9aHdHMGFD1uOGu9o8fEpStnn5UmGPJcMwlWEHdx?=
 =?us-ascii?Q?BzkbOJKrkgbbc4/i/M4QB0BX8wjIo1Qx1QqrSmb/8AQW1tN9fOjiZR+lb9xr?=
 =?us-ascii?Q?sfv8VGTu9Z0ShzVY/L8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:40:51.9465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d48537b1-52d5-4b35-2f39-08de1c81b37c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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

Summary:

* Enable VRR when unsynced with the stream
* Refactor DSC cap calculation for dcn35
* Add debug log for power feature
* Fix fill latency issue
* Do not initialize LSDMA if it is not supported by dmu

Alvin Lee (1):
  drm/amd/display: Only initialize LSDMA if it is supported in DMU

Chuntao Tso (1):
  drm/amd/display: To support Replay frame skip mode

Dillon Varone (1):
  drm/amd/display: Fix index bug for fill latency

Dominik Kaszewski (2):
  drm/amd/display: Change lock descriptor values
  drm/amd/display: Revert in_transfer_func_change to MED

Fangzhi Zuo (1):
  drm/amd/display: Refactor HDCP Status Log Format

George Shen (1):
  drm/amd/display: Add interface to capture power feature status for
    debug logging

Ian Chen (1):
  drm/amd/display: Add new SMART POWER OLED interfaces

Ivan Lipski (1):
  drm/amd/display: Allow VRR params change if unsynced with the stream

Leo Chen (1):
  drm/amd/display: dynamically clock gate before and after prefetch

Mohit Bawa (1):
  drm/amd/display: refactor DSC cap calculation for dcn35

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.35.0
  drm/amd/display: Promote DC to 3.2.358

 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  30 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 242 ++++++++++++------
 drivers/gpu/drm/amd/display/dc/dc.h           |  28 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   6 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   7 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |   5 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   2 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |  31 ++-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   7 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |  52 +++-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   2 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   4 +-
 .../link/protocols/link_edp_panel_control.c   |  17 +-
 .../link/protocols/link_edp_panel_control.h   |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  10 +-
 .../amd/display/modules/freesync/freesync.c   |  11 +
 .../drm/amd/display/modules/hdcp/hdcp_log.c   | 124 +--------
 .../drm/amd/display/modules/inc/mod_hdcp.h    | 126 ++++-----
 .../amd/display/modules/power/power_helpers.c |  30 +++
 .../amd/display/modules/power/power_helpers.h |   5 +
 23 files changed, 464 insertions(+), 285 deletions(-)

-- 
2.43.0

