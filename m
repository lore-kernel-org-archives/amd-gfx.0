Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DAFDC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC0210E111;
	Fri, 31 May 2024 16:52:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mj2kQdLt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7306D10E1D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB7f8gS9pGYR2/qNHktZI6quhKVRglK9Kq6HYkzX50Qij9D7t3fPYq485EP76ceTjsvQtRUkCbC8OeNJR/W+QJBzQd21CfF9lKKyT/+VJ772A/bb1wifvyD0rRjMD3CExBsD6+RZugY1tQmIef5gAWudTNFSEQ0LTsqWsJ3orgWeGysk6MJg1aLJpJpAvxtYVNTZTTQTCd/9tsNhRq6x3HWQWvKiBVcsqWDKDZesikXLOAc5GYP3a/BpF0pXFeD3d5f5gyhKlJClzxpe2E3/RxtsGDt2mX/RqXiEcEd4NRRTeK7cSwi4/gCKsP2zxLMyrV+WpsYYoGKiBqQgd5dBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KbNh3HeP+mcewgom3T6Vs9MHznPhrAlxN8rpUN/UQo=;
 b=cj2QZfV4mPp1qw/3ApUQZNqSSi7VdMo5yNqBCz2ek9uHtVL1JzQpBOpWXl9oAEH3eHFwszOrC/fM+2nTKHt31sbc/q696MZmVPtPoChybCHCHIBoQ5dvShM73K6cI/1qhaV3VGXOVu623A+ZufPwi02fu5us31BaXNSOXP83KnL/C9mY/M4Sh0vz9T9BP1htY1fMVKP9bPnZ1gRnDK+3ANfEn3Zx+MkqSqcLHXriqWcGz2scGQ2EpfYD+88qqOPn1RUpJE4rhO7ZmXxydENphteb8zJr8CUhIKVVX6psuABnaJXHMwmyjsIllyMHy6WNQqiTlRV8tNzB5Ab3Kw5aYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KbNh3HeP+mcewgom3T6Vs9MHznPhrAlxN8rpUN/UQo=;
 b=mj2kQdLtaQ6V7vxMpvO3R2Xq3rS0+FJVfY7sYPitn5KeaMPyMWUMVoHjbKr27ru38VfyF6lFBS6Kt3Pm8LQq29GVQtXHq5X7ozo0lMVecmPdkZi/gatN/oFudYcKG8kLPXU31haI/DMXiouEMU5umUrom0PexZ5tNO9lf3Vf13E=
Received: from PH8PR20CA0022.namprd20.prod.outlook.com (2603:10b6:510:23c::22)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:52:20 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::e0) by PH8PR20CA0022.outlook.office365.com
 (2603:10b6:510:23c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 16:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:19 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:18 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/32] DC Patches May 20, 2024
Date: Fri, 31 May 2024 12:51:13 -0400
Message-ID: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: bee509ca-2b17-4b06-4421-08dc819208e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEhIZTMxZ2Q4RVBkMThBaWhqRHROcXk3V2ZWSjJXcExaTTNFZnJENWFvUVdo?=
 =?utf-8?B?ZHZiYi80ekNlWklxaG5XZUpOUGhVMlY1NDdoWXU1U1ExQm5YUFJzTXZOZy8y?=
 =?utf-8?B?c2grYU81bXZUa0RMRmxoUDB0QjloN2F6UG5CNHIySnRueVNoaTRnTVQxLy9x?=
 =?utf-8?B?UENuaGY0Q3h1Zjl5dFZqTUEwcWE5Y2tHSlpGUlpiK013V2Q3b1hMK2IzSXQr?=
 =?utf-8?B?UUJhbmhiR0J0ditua1paVlRBT05QdWtxRkxIKytRNDVRK21JalZuSzJoektI?=
 =?utf-8?B?aEI0eFMrS2RFa2JvbXo5N25PTmF3M0FOUmRTWEFFUzZlMnVscGN5Q1R3YVB6?=
 =?utf-8?B?WWJrZmh6R1JONUtEVm5IRHozcGZFTGRvM0grbVNkakMrSGhyQXpkRk85RWdw?=
 =?utf-8?B?bkNhK0JFcHVJT3pBUGlBN2h1OUUzUnNGY2tyWkVCMU1veXQ2a3Q5OGJQZ2Zh?=
 =?utf-8?B?b1VwOFhSRnBNa1IwS041endRNFdvWkJQZVA5V2d5ZEpNekcrQVVPY2VyOHJ5?=
 =?utf-8?B?cGtrcURtNkdFS25mTjJiMlBpVlNlb1BOTlJzZlpYL3VqRlRMWnZBUG9ueHlL?=
 =?utf-8?B?WWhxWVUrTUVrUkh6dTR6M0ZWMlNmYnBZVXRLdzFTRVZZaXhKb08xZ3g1VkJp?=
 =?utf-8?B?M3JvSnVIdG5ja05CSWtoYy9TbUFHTnhFd3piMlZhWnFxYVdQNlA3UUdrZXFm?=
 =?utf-8?B?VWJzTlBQRlZXaXhrZ0pYOGlsMFp0ZStnY0hJVUZFOXZoZEJ3c1duVG5VQnJD?=
 =?utf-8?B?UkF6MVJBbXdnV2VJVHc2T3VRQ3gwb3FRMDFld045TmQ4elk0cHpielYyWjZi?=
 =?utf-8?B?ZHIreU5jVk5rdGVKalFXaUdnam9DQkthcDgyM3FzbnNwM01WYk94QjE5STZB?=
 =?utf-8?B?NTN4S0hlZS9LQ0hXMGo3bWJJQ3JrWWFSd3VPNTNZcnhndFM2L0ZWVkZYMzYx?=
 =?utf-8?B?ejUwNDRiT0x3TENWcGRiWkFrUURaRGJMTUNFODlwZTZxenhrcHppMjBBUGhD?=
 =?utf-8?B?WElxdHRJK010U1FsTVZiZWNIeElpS0s0YnlBNFNoT3N1Vk1WdDVYVFdUNmdi?=
 =?utf-8?B?YUI3dnB2QnUwN1VOS3YzdzYzRG95T3I1OUJTaWtvcDVzNXpXanFrYkttbmNZ?=
 =?utf-8?B?cUNSSDJoOExuditDN2x2SlBSVFRqeWFjRm9XOUxkZmhKcWRxZUNjTU1Fd3pV?=
 =?utf-8?B?RjJ5ZGdWSW5OQnJ0V1BNNGpCWWtEV3NRa1JGbTNBZ05VN3FMR1hGemlRVlFu?=
 =?utf-8?B?bldMNmVvY0xrYTZsZ3gydHVyd1NMZEF4dERNN2FRSk5PcGpJeW5PNlk5UXpX?=
 =?utf-8?B?QTZpdGhmWFB3dWI1YjNTaW5pQ052eEgrVXIyU2tEMHRWOTl0b0JTWTZCZndZ?=
 =?utf-8?B?d1hzbXB1MjU1OUV6czBXTEVrMWpTU2grREFDY0dvYit2UjVZVnhFVlJxUCtK?=
 =?utf-8?B?NUhJMTMzdEVHNko5TnVnSG5telJzY3FiVllGakpneFZGTEwxNFZ0dnJQTkVE?=
 =?utf-8?B?dFJncmpMSi9SbTlnNFZhSVUrdkVUbVhPVkVVdHpEakV1MHBuSXFGbURocll6?=
 =?utf-8?B?cDJHSk5qWm9iWk5vTy9Sb1h1ZnNobGVidk5iY1ZHWTlIWStVaFQ0ckQ4UGFR?=
 =?utf-8?B?YmFFQUdzVUpobDVEbVdhdVZ0dEhtQnZKeHNHMVoxaVlENCtnakJia1NvVG9U?=
 =?utf-8?B?cWFBbjJTSnQvZEQzSGF3UzdLNk9nRDJoOFZvUER0SURkekttOEFaSkNJNXhw?=
 =?utf-8?B?WVhpb3AwQlRHZG1nQ3hINUFweUFhS1gyczFuQ0l6VjR4U2NZUWZmZjVOWmJh?=
 =?utf-8?B?ajdvcnhlbU1HMG5wZVNIbmNGY0JyNlZIVjA2cWRNeGdJQ0YrUy9kVFZjcVhx?=
 =?utf-8?Q?uCZ4BMvJ+kGGl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:19.3412 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee509ca-2b17-4b06-4421-08dc819208e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005
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

This DC patchset brings improvements in multiple areas. In summary, we have:

* DML2 fixes
* FAMS2 Improvements
* Fix YUV video color corruption, oled eDP not lighting up DCN401
* add UCLK p-state support message for DCN401
* Extends PSRSU residency mode
* Introducing deferred replay coasting vtotal update
* Fix DSC slice and delay calculations

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Increase MAX_LINKS by 2

Alvin Lee (4):
  drm/amd/display: Only program P-State force if pipe config changed
  drm/amd/display: Move fpo_in_use to stream_status
  drm/amd/display: Use current_state when checking old_pipe subvp type
  drm/amd/display: Program DIG FE source select for DVI before PHY en

Aric Cyr (1):
  SWDEV-1 - dc: 3.2.287

Chiawen Huang (1):
  drm/amd/display: add set ips disable

Chris Park (1):
  drm/amd/display: Support new VA page table block size

Chun-LiangChang (1):
  drm/amd/display: Add params of set_abm_event for VB Scaling

ChunTao Tso (1):
  drm/amd/display: Introduce deferred Replay coasting vtotal update

Daniel Sa (1):
  drm/amd/display: Fetch Mall caps from DC

Dillon Varone (5):
  drm/amd/display: Wait for hardmins to complete on dcn401
  drm/amd/display: Add UCLK p-state support message to dcn401
  drm/amd/display: Force max clocks unconditionally when p-state is
    unsupported
  drm/amd/display: Add recovery timeout to FAMS2
  drm/amd/display: Various DML2 fixes for FAMS2

Fangzhi Zuo (1):
  drm/amd/display: Prevent IPX From Link Detect and Set Mode

Jack Chang (1):
  drm/amd/display: Extend PSRSU residency mode

Joan Lee (1):
  drm/amd/display: Add retires when read DPCD

Joshua Aberback (2):
  drm/amd/display: Fix swapped dimension calculations
  drm/amd/display: workaround for oled eDP not lighting up on DCN401

Lewis Huang (1):
  drm/amd/display: Add monitor patch skip disable crtc during psr and
    ips1

Nicholas Kazlauskas (2):
  drm/amd/display: Add outbox notification support for HPD redetect
  drm/amd/display: Guard reading 3DLUT registers for dcn32/dcn35

Nicholas Susanto (1):
  drm/amd/display: Fix DML2 logic to set clk state to min

Relja Vojvodic (1):
  drm/amd/display: Updated optc401_set_drr to use dcn401 functions

Samson Tam (1):
  drm/amd/display: fix YUV video color corruption in DCN401

Sung Joon Kim (1):
  drm/amd/display: Fix DSC slice and delay calculations

Wayne Lin (1):
  drm/amd/display: Change the order of setting DP_IS_USB_C flag

Wenjing Liu (1):
  drm/amd/display: turn on symclk for dio virtual stream in dpms
    sequence

Yihan Zhu (1):
  drm/amd/display: bypass ODM before CRTC off

yi-lchen (1):
  drm/amd/display: Keep VBios pixel rate div setting until next mode set

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  10 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/dc/clk_mgr/dcn401/dalsmc.h    |   3 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 165 +++++++++++-------
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   3 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   | 127 +++++++++++++-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |   6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 ++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  12 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  16 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   2 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |  12 +-
 .../amd/display/dc/dccg/dcn32/dcn32_dccg.c    |  12 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  13 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   5 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |  18 ++
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h |   2 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   5 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   3 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  40 +----
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |  10 +-
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |  39 +----
 .../dc/dcn401/dcn401_dio_stream_encoder.c     |   3 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |   6 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  15 +-
 .../amd/display/dc/dml2/display_mode_core.c   |  45 +++--
 .../dc/dml2/display_mode_core_structs.h       |   1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  |   2 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |   7 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.h   |   4 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |   6 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   1 -
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  29 ---
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   2 +-
 .../display/dc/dml2/dml2_translation_helper.c |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  18 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  29 +--
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  16 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |  27 ++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 ++-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  23 +--
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  21 +++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  63 ++++++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   5 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   9 +-
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   2 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   2 +-
 .../amd/display/dc/link/hwss/link_hwss_dio.c  |   7 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  33 ++--
 .../dc/link/protocols/link_dp_capability.c    |   3 +
 .../dc/link/protocols/link_dp_irq_handler.c   |  26 ++-
 .../link/protocols/link_edp_panel_control.c   |   7 +-
 .../link/protocols/link_edp_panel_control.h   |   2 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |   4 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |  11 ++
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   8 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   4 +
 .../dc/resource/dcn401/dcn401_resource.c      |   1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  95 +++++++++-
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   6 +
 .../amd/display/modules/power/power_helpers.c |  14 ++
 .../amd/display/modules/power/power_helpers.h |   5 +
 75 files changed, 810 insertions(+), 323 deletions(-)

-- 
2.34.1

