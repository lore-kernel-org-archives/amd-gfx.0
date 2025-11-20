Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A81CF9C7C
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 18:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76DE610E7A9;
	Thu, 20 Nov 2025 18:16:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lndIjWbM";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EADFC10E7A9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 18:16:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywfMRb6+lGVjaYWcEhZmFN8MWCnmu6Sqll82Uh0zYWkq6R8QGN4kInQc7vppeAhTyijVMkvt76WEA3UrUCN6rFa9gPxDAbYuKLoppBFDxBDOO2o4sz8e9wnwOvSKlG28HrIli1FK6qG9y9Me2oSMntvF8JOSpt9oDO5OPuJFL3Ivm5ba0E/qeDfuhpqllBmiQqCPzUhGXIcwQtQbqu1/QOyT5R8zzKDbKkyHgcW/oZ3UG0LXw2DD07mYSBl3LSNgn+rNy3IbeDe+FSpJjjwyn0q4NsLS69pAtJ0IY/no1En81I9U9uEI/PLrOypbY97h7f5KApKxBLV+RHN2Dh0a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYUn2qb9p2j8KZcpTvNzFOFyjxj8IICMBwtA+8Sm1gE=;
 b=lHaZpYbrjiXCif9pgN9d2bPgDTrVFyplKQ9ldtNkzSE8GTsQM1ccWOjHDhNouIdY7wFg+Ttu49fa7Tzqao4FcQyDIpMeAW8aKf2k2kTKvchQywFOZbJlP5Rc3/0t8uCSnSCinsF0kM2TiOJQmY+wONw50mWfJkdLE1d2HHCDfJti/ovcm1iytYiK+Gl6bYjs059Oj+tuqGNh5Vqjonvex1sN+eUp2zJo0D6x8swYbXYnSa10gHgcn2xkxZVE59x01Tv9IpBTSFJDJFe0d2ir4rv/A2RxKcFcS7EKA1lx/MPaIQ2u7dQeMgm0nCEal33zqhXqO2qsXQuvyutJ09O6Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYUn2qb9p2j8KZcpTvNzFOFyjxj8IICMBwtA+8Sm1gE=;
 b=lndIjWbM8Ua2KzjrNsCFpgvfpEqtV+O3RM6QVLd6MW6ImJZA0G99qjw864vkPlIjnKbnjTMgdnqJ0aeprryV6/dpb12I+X8Z68gP8/CBn3u51D7l3YRFbKTNb3cTNtoVDDq2ARSdmMJGCSXfOaBFKzNMDMs2HCy+zsOOmYy0xjQ=
Received: from DS7PR03CA0108.namprd03.prod.outlook.com (2603:10b6:5:3b7::23)
 by MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 18:16:52 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::8d) by DS7PR03CA0108.outlook.office365.com
 (2603:10b6:5:3b7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 18:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 18:16:51 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 10:16:49 -0800
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 00/26] DC Patches Nov 20, 2025
Date: Thu, 20 Nov 2025 11:02:56 -0700
Message-ID: <20251120181527.317107-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: da1dcda3-19b9-4bbd-90e2-08de2860fa6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUUxMkwxd0YySG5ZWDVWMHhUdytpaVlka1Q5ZVEweUlRZVdYVXo1RHFFMCtl?=
 =?utf-8?B?cThOMjJkMjRwWEEwbzUyU1RaektSMXgwVmlSVkN5ellmWHJqeGgrMTVTV0xV?=
 =?utf-8?B?NXhYU3Bnbi95MHB4WXJVc29GVXpHTWxnLzdURUp0QWQwQzJrdFhIbXNxbGh1?=
 =?utf-8?B?NWpYRWprV01QSEphdmI4R0xYNVFnMWdwNlNPM2FqVVhacnY2cHhkSElIclFj?=
 =?utf-8?B?RXpyVE1RcnJRSWhOMkVwclNZdUlQNHFPZTVFckpGY0g0a0tEdWM4NVkydXdH?=
 =?utf-8?B?eU5EdlZ2OWZwQkgxQTFyeExmNlJXZzd1TGpEVVN0Nk12dkNvd3o4dFpzYzVJ?=
 =?utf-8?B?eVN1N2FWR2hsUGJyQjg4dS9OQUs3WXhrWGk4aUg1VG1tWFZCL1dXRlkwYXpJ?=
 =?utf-8?B?N3ovVGYvTVdkRzlXeE9qaTFGOWlta29HK01VUkVSSW42TXpiQXdTeHlrR0xY?=
 =?utf-8?B?VC9LWDlPcVlXS0pJaSs5UjFscnE4YVkzUjZrS2I0TEtRWldyNEd6LzRUSjZN?=
 =?utf-8?B?RWNoRDdVb0c4bGxOVEFpNkNUUG41WVp4c1JQZnE1Tms3UkxBTCsvWHB2Uy82?=
 =?utf-8?B?SEQ0T2IweFdQajJwYmtoTWdMNTh4c3d0WmZ0L1JEeFpNMHBCSmdUYjVGVUtQ?=
 =?utf-8?B?aldtZmk2Zmx4TWxYNXNSTTJIc3dobDRRRFlONUVQWmw2ZGNLZ1kxbXBWcVN1?=
 =?utf-8?B?YmFvK2pwSGFmdzdKQU9VK2JTUE5FMEEyL3lacDRCWlNwNEUxK0xqaDZ6UThk?=
 =?utf-8?B?aUlETERwUDJMVUQ5TEluTTRxZm1jMmlaZGFrRk9TdTdmWmdrbklaVjl1cFpk?=
 =?utf-8?B?ZTJuTGFhOUhxUFd4cDFLTjdHL3ZoZGh1bVg0eFo4bzdESWJTMVp4d2x3SXFS?=
 =?utf-8?B?YUU1R2pJWmpnT0p5YkRtVGRlYm5DU0tPS2Q0cVBJVWttcHFYWXJDQmloT3dO?=
 =?utf-8?B?NGFiRUQvQ0pqdmZEamVnVUczbHdDNG5QaUE1OStjdG5ETTJZT1ozRzIrV1Ix?=
 =?utf-8?B?cndiN2UweUNKcytjaGJzUWh6YmZBWG9hNWtCb0ZJUEg2a1lCdTA0QTBNSVVy?=
 =?utf-8?B?c0duanVjYUdnT3EwclpnMXpoUHpSNnZUWVpDZzYxSExrWUVyUmVkb0Y1ZFBT?=
 =?utf-8?B?QUcrSkdhNkFiQVpwRFNYL1Y3UnV2TjZBcE1ObjZWOUVabThaQ2JKMUt1TlNa?=
 =?utf-8?B?U0t5Qy92WUJiY2tXWFJoQmdRSXBBMHc4RThhWUlhUlErS042VmJ3M0hjOVlL?=
 =?utf-8?B?R2lDSzlZTDI3clM3dFY3R1g0TUVKNnlQK09UTTdielpYR0xrZVhSb3JiSmxk?=
 =?utf-8?B?NjdiV1ZTTzFMSjBQVE1kWDFvUncwb0J1Z09lTkRsNXk4b09VTjAyNWkzbDRy?=
 =?utf-8?B?aE51UGw2MW00VXlkVUtpZ1F0eXRVSzZZNklPeitKQitYUHBQWTljTFBPV1Zv?=
 =?utf-8?B?TkxabENacGUraTZNdUV1a1FmKzIwSk1RQkYxSVlERzVCV1NRbCs1K3phKzly?=
 =?utf-8?B?akNhM0dKa1h0R0dPdkY0VjlDTk94RVNzQXFxUWp3dXZUVTk5RHdaQ05icmFp?=
 =?utf-8?B?aXBWUlJDRDZEVGpYNGVrL2NhajBlM2ltRisyTWNCUE5QQVdrNm8wdU9xZHlM?=
 =?utf-8?B?OXdBanRXUFlydVkyYTRsRUVrU3hDc0dRTTQzUGFkdmh6RnFNcVM4aC9yU3NY?=
 =?utf-8?B?c09tRENYN0E5d0hsTUFwNkRQZGp3M0V6d0thcGtQVno2U0FaRjFmTHN0M3Bo?=
 =?utf-8?B?bTZGSVdqMEhGMjl6VDJ1eVN4ajJwRzQ3ekFlblVLSHRUK0RuNUt4NzBIcEdj?=
 =?utf-8?B?TzlCdURXU214Mjcvc3QrNlFTWkF1OWt2WXNQUnd2cStRTS9xVnpuY1RUcWFq?=
 =?utf-8?B?RmZNQlkwWmNudlFSMmNPcWFIaGR1SmVpZnJRcUNPM1ROQ2pIYUErVUpwczhm?=
 =?utf-8?B?dGZMUXhlSE5jM3hPVnFwWnRFRENvWjlTY1hSc3BmZVNDOE80cVA3ajhIMWR3?=
 =?utf-8?B?ZVFmWTRIcWMwMy9TVzhQZUQrZTVrQWJxdThHZmkxQUNkVkRpN0pqcFMwYjZJ?=
 =?utf-8?B?eDY0dTQwTGs1STlkMzAzd2RTajhDeVFrT0dYT2J2Sk0vbDZzL1dpNlArdUYr?=
 =?utf-8?Q?hV5o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 18:16:51.6219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da1dcda3-19b9-4bbd-90e2-08de2860fa6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802
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

* Fixes on mouse cursor and some panels
* Improvement on brightness
* FPU and DML refactor
* Code cleanups and readability

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Check NULL before accessing

Ard Biesheuvel (1):
  drm/amd/display: Permit DC_FP_START/END only in non-FP compilation
    units

Derek Lai (1):
  drm/amd/display: Write default Vesa Aux backlight control in dmub

Harry Wentland (4):
  drm/amd/display: Rename dml2_wrapper.c to dml2_wrapper_fpu.c
  drm/amd/display: Move dml2_validate to the non-FPU dml2_wrapper
  drm/amd/display: Move dml2_create and init to the non-FPU dml2_wrapper
  drm/amd/display: Drop FPU flags from dml21_wrapper.c

Ivan Lipski (2):
  drm/amd/display: Improve HDMI info retrieval
  drm/amd/display: Check ATOM_DEVICE_CRT2_SUPPORT in dc_load_detection

Jack Chang (6):
  drm/amd/display: Refactor panel replay set dmub cmd flow
  drm/amd/display: Add AS-SDP v2 support for eDP feature
  drm/amd/display: Parse debug flag to PR FW
  drm/amd/display: Fix sending redundant enable command to dmub
  drm/amd/display: Revise VSC SDP header for Panel Replay
  drm/amd/display: Refactor panel replay dc libs

Mario Limonciello (AMD) (6):
  drm/amd/display: Don't change brightness for disabled connectors
  drm/amd/display: Improve readability of link_detect_sink_signal_type
  drm/amd/display: Drop needless check for link->link_id.id
  drm/amd/display: Move CONNECTOR_ID_PCIE into switch/case
  drm/amd/display: Correct comment style
  drm/amd/display: Increase EDID read retries

Nicholas Kazlauskas (1):
  drm/amd/display: Add cursor offload abort to the new HWSS path

Ovidiu Bunea (1):
  drm/amd/display: Add additional checks for PSP footer size

Relja Vojvodic (1):
  drm/amd/display: Correct DSC padding accounting

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.37.0
  drm/amd/display: Promote DC to 3.2.360

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  66 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  10 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  16 +-
 .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.h    |   8 +
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   2 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  24 +
 .../drm/amd/display/dc/core/dc_link_exports.c |  22 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  11 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  45 +-
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   8 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  | 599 +----------------
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |   9 +
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  | 604 ++++++++++++++++++
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.h  |  25 +
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  13 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   4 +
 .../drm/amd/display/dc/link/link_detection.c  |  45 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   7 +-
 .../drm/amd/display/dc/link/link_factory.c    |   4 +
 .../dc/link/protocols/link_dp_capability.c    |   2 +-
 .../link/protocols/link_edp_panel_control.c   | 177 ++++-
 .../link/protocols/link_edp_panel_control.h   |   7 +-
 drivers/gpu/drm/amd/display/dc/os_types.h     |   2 -
 .../dc/resource/dcn20/dcn20_resource.c        |   6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  33 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  57 +-
 .../amd/display/modules/inc/mod_info_packet.h |   6 +
 .../display/modules/info_packet/info_packet.c | 369 ++++++-----
 33 files changed, 1357 insertions(+), 836 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.h

-- 
2.43.0

