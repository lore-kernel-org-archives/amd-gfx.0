Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FFCC27C5E
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 21:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40CD10EACC;
	Thu,  6 Jun 2024 21:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qXDKwF8k";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAC0710EABC
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 21:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ogoPt1JL6Mz/X9rUbEiKtzWp5QQORVdUGDjiCf/utsqCNG6EEHqhQqcWjvTkyOfNapS11Ah35aoT8TPCkKetxLfmzYMGykD01L9nu0a7cuciBvg5T5WpCNAcxbMTucHIu/NcyjfHDp5nnRfEwjFNIr1STnwnPIfOVd2Wqkzp+YOM//Py6EQe3hs4VVE8yPtbUa0gjd3yGGeAxe9mf6ks6KC4nEN1l/J5HLAHM09M71MRBDtsrO3HBCdjhCVvAf7VD3xFt/wSMfcTSs/nGWVnjdQMYCsXzmqtQVN7LmcSGVENY7UHTa9u4+YPL06MHGb1aN+E5vf1+SOY0g/16Yotag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzqY83dWCk0Onh8UlQOYDu3tCGi8diBsX/CbU1AlRSo=;
 b=mLm7SnJ0MW5kldnlxj47sLZeydxPt3TSGOr1A/XP3El0dZuo4eZ3L9cAGKMWpXTpaxBaMNxFQTBSYWTseAuKsDQfnSE2azVYMSgAvyuLwxb3jM2Ji2ZKml1VM47ZvlTRkb3hyzgrDTwR6QmFmTJF1Ftr0wmdh4+XmPUcAjGyt5qJh9+l5/mkS8cVJ0fAov831U6oO4ReW4UyoIhNqEAAyhGOJGCBW6+5eEUTmB07gcqMGO27/FNo5JNQU1duJXAfhlXWWJqTMFYjrF8q2BTXFbEX6Xuj2yKcp4CB3walJIVmMhKZ8bSklwcuCp2uO8MTwLgAtccWXEeDD+le6v+WCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzqY83dWCk0Onh8UlQOYDu3tCGi8diBsX/CbU1AlRSo=;
 b=qXDKwF8kpzUUTc50PJzy0Kc7JhbZ3va42gLY6Q8Rf2a0eH+/GeRZC6xuFtUzV2i13hkjFZ/y6G9rUiTLVtV7/ew53pMcZto/GXNxqFX2OsOqXTctEqNZIp14bGTqgENtAvw4Z1uvrjA7GF6vgar5j+Mre+aSUwP6xLMM/xN31i8=
Received: from BL1PR13CA0001.namprd13.prod.outlook.com (2603:10b6:208:256::6)
 by DM6PR12MB4188.namprd12.prod.outlook.com (2603:10b6:5:215::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 21:56:53 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::57) by BL1PR13CA0001.outlook.office365.com
 (2603:10b6:208:256::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.12 via Frontend
 Transport; Thu, 6 Jun 2024 21:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 21:56:53 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 16:56:51 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 00/67] DC Patches June 3, 2024
Date: Thu, 6 Jun 2024 17:55:25 -0400
Message-ID: <20240606215632.4061204-1-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DM6PR12MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3e96e2-09e4-42ad-8b67-08dc86739371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YzZHc0VrM21Wb3hqY0M1V2RQb1hLUTlrSWw2bEZDbTVTUzR4Qkd3SmFSVi9i?=
 =?utf-8?B?T3FHQnZRc1VrRFJncVJDSG1BMnNsYUxqQVA2ZTh3cnJDbmpXTDFtdHc5dmxR?=
 =?utf-8?B?UHpISm9LMnBKSU9PRDhFSlYrY0VDUURld3lMNWVWVEJYaytrTWIvKzRaKzBn?=
 =?utf-8?B?dkdrTkI5dTcrU0tqMEVjT1RXRkpwaEpsZUlDOUczT1BocXV6QnI2TFlYL2Fi?=
 =?utf-8?B?ek90TDdqZ0s2YmR5WFZnSHE3Z0w5aWZvcEJ5WW9VOGVQcWhPMlFaNnJEYWxL?=
 =?utf-8?B?bkJWQ25iZGZ2SWZUUkVqRE5MWGRwSG0zVWN2bFZLMkNtZmY3SUVTVTBDcnlE?=
 =?utf-8?B?WlFHeWdBUy9kaHhHRWZMbTh1TUp0U3F1amJwMkxDSGp0dXJ3Y2ZhWDB5UDJn?=
 =?utf-8?B?RHRRK3NVTS9mZndJSDBiTDZSTFg1Y3ZkZUFPMHo1Y2IvQTBZUThMcDZkcnJ5?=
 =?utf-8?B?eG81NEJ1c1UwU1h2V0ZKVHllNC9qRm5CbUtiTHd5eFY1SUhYTUU2T2MxMjla?=
 =?utf-8?B?MHRCR05XaTdPQVVCZThlYnBsbXVhb1BqRGl3ZE80VWhiQzM1UVZjc3NNdkFh?=
 =?utf-8?B?QXZqQi9kRFYwNEhRb3RoT1h3d0lSa2hTUkpkNGVTLzZLVlVKLzc0THVVNS9j?=
 =?utf-8?B?Q2o3bzNiN05HRnVTRXFRVzZVNzNqdzR2NE9USTJyWDU2QThaZG9na00yNHJs?=
 =?utf-8?B?ZnJ2am14S3c1SHJKQmg0SU9VYzU4VllQZk9XWjFrSEhUSmcwRDZhTGUyeFRZ?=
 =?utf-8?B?SXE3eFRGalh3eGt1ODAwVjJOU2lvVTFGa3Y2eGR4bnRmSGlaYThjUnRmajRq?=
 =?utf-8?B?ZUhMQlppUzBzNUFXbVo2a3g5NXczdU1NSTNvTFk3TWVuVVMxMUMvNmF2elQ2?=
 =?utf-8?B?VEJqT2dSZ3RIRXFQNVRsUkU2Y2pLNVBMaWloQTgwdEVqeUVsT2NoM2FYbldz?=
 =?utf-8?B?YlNlKzhMUUJmdFhON25xeEZkR3hiKzB0RG4wY1M2QUt1RUg3YkRyTFBwYXgz?=
 =?utf-8?B?Wm16RVJrTFVyZUZXM3Jqb0tTdDQ3eWxZVzBZeks0bGNBb2Q3eVY1WE14eGNI?=
 =?utf-8?B?OWt5Ym4zTjgzRHdhMVM0MjZUZHE0cjNta05udlY0cHZIYkxSZk5VVkZVak90?=
 =?utf-8?B?bnd6U29JdjN5bUxwWkx6WExRZFJXam5HY1JackNET3VFQ0dWNU85MWV6YlAx?=
 =?utf-8?B?alVJNHVUVjBld2JYRWlZdGZNb3ZKWENLRlJqODZqOEIwcTVhbFI0NGNjR21O?=
 =?utf-8?B?bXorWVZnVTR4VTBMUkhBRHpQNDBXdlJsaXZPSXdtL1VUdC9FbDZtK2tNZ0hY?=
 =?utf-8?B?WnVMVVpvN0p4SkFrRmplU1pXNE9MWlV4Q3pFNDFNT0N4R1dXNGI0Nkp0Y25H?=
 =?utf-8?B?K2Z0a3RCU2Z4cFJMRWFtY3ZqdFlPOXZMUm1keUJ6dzhrVUFjY2FsNDl2OUgv?=
 =?utf-8?B?U2VtaytRRXdlUmdJMzNvLzNncGZoRXFwWStxeGZaaVRseGdtbUhselJOeDlp?=
 =?utf-8?B?QjVINmdQNmQrREEwQkFGenhkbHdCTnVzSmlneW5YWEtmcGlPK2RBdUlJU1Jq?=
 =?utf-8?B?VkpwTGMvR2N5V05LRmVYNm1PR1ZiTXlWTmFIUk5ja1ByaWRzS1Ziekh0cFU1?=
 =?utf-8?B?WDJSU3psNGJPL3ZvWUV5VGd6YllZV2k4U3oxU0V2S29PY1U5UFFsVEhSNldh?=
 =?utf-8?B?Y3FuSGxUL0dteGNqdlo3VDlUeU5IRXZHSWloVmt6aXNYYnpCdVI0bFYxNkJi?=
 =?utf-8?B?bUdXdllQa0N3Tmw2U1JTU2YyaDBoMjhYOUxtMmROUWpoL2hsU1ZsWk5ZbDc4?=
 =?utf-8?B?T3NENDJMaDQ2aTM3Kzk2R1RIOGcyNy9iYXFObE50MXl1YUdDVmxsbmd3N28r?=
 =?utf-8?B?S0JtWmJYUklpNm9hTEF4OUd2cjE5TFE0eVY1c3dpeDJLT1E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 21:56:53.2195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3e96e2-09e4-42ad-8b67-08dc86739371
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4188
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

* FW Release 0.0.221.0
* Fixed missing targets in FAMS2
* Populate hardware_release hook for dcn401
* Disable DMCUB timeout for DCN35
* Move PRIMARY plane zpos higher
* Introduce overlay cursor mode
* Change dram_clock_latency for dcn35 and dcn351
* DCN401 cursor code update

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (6):
  drm/amd/display: Fix incorrect size calculation for loop in dcn401
  drm/amd/display: Fix uninitialized variables in dcn401
  drm/amd/display: Remove useless comparison of unsigned int vs. 0
  drm/amd/display: Remove NO_EFFECT self-assignment
  drm/amd/display: Explicitly cast v_total to signed in a subtraction
  drm/amd/display: Avoid overflow from uint32_t to uint8_t

Alvin Lee (3):
  drm/amd/display: Remove NULL assignment for stream_status
  drm/amd/display: Ignore phantom DTBCLK requirement
  drm/amd/display: populate hardware_release hook for dcn401

Anthony Koo (2):
  drm/amd/display: [FW Promotion] Release 0.0.220.0
  drm/amd/display: [FW Promotion] Release 0.0.221.0

Aric Cyr (1):
  drm/amd/display: 3.2.288

Chris Park (3):
  drm/amd/display: Change AVI Info Frame version to 4 for OVT
  drm/amd/display: Prevent overflow on DTO calculation
  drm/amd/display: Avoid programming DTO if Refclk is 0

ChunTao Tso (2):
  drm/amd/display: Replay low hz
  drm/amd/display: Replay + IPS + ABM in Full Screen VPB

Daniel Miess (2):
  drm/amd/display: Change dram_clock_latency to 34us for dcn351
  drm/amd/display: Disable PHYSYMCLK RCO

Daniel Sa (1):
  drm/amd/display: Return after Init

Dennis Chan (1):
  drm/amd/display: Fix Replay Desync Error Test

Dillon Varone (5):
  drm/amd/display: Block SubVP if hardware rotation is used in DML2.1
  drm/amd/display: Add null check for phantom pipes in prepare mcache
  drm/amd/display: Fix missed targets in FAMS2+HWFQ
  drm/amd/display: Do not override dml2.1 reinit
  drm/amd/display: Update idle hardmins if uclk or fclk requirement
    changed

Fangzhi Zuo (1):
  drm/amd/display: Update efficiency bandwidth for dcn351

George Shen (1):
  drm/amd/display: Ignore UHBR13.5 cable ID cap for passive cable max
    link rate

Ivan Lipski (5):
  drm/amd/display: Remove redundant if conditions
  drm/amd/display: Remove unreachable check
  drm/amd/display: Remove redundant ternary operation
  drm/amd/display: Remove duplicate 'update_idle_uclk' in dcn401 clk_mgr
    code
  drm/amd/display: Remove reduntant comparisons by Coverity

JinZe.Xu (1):
  drm/amd/display: Disable IPS when it is not allowed.

Joshua Aberback (1):
  drm/amd/display: Disable boot optimization for DCN401

Josip Pavic (1):
  drm/amd/display: define abm debug interface

Leo Li (2):
  drm/amd/display: Introduce overlay cursor mode
  drm/amd/display: Move PRIMARY plane zpos higher

Leon Huang (1):
  drm/amd/display: Expand supported Replay residency mode

Michael Strauss (2):
  drm/amd/display: Update FIXED_VS retimer training pattern delay
  drm/amd/display: Add fallback defaults for invalid LTTPR DPCD caps

Nevenko Stupar (1):
  drm/amd/display: Fix multiple cursors when using 4 displays on a
    contiguous large surface

Nicholas Kazlauskas (3):
  drm/amd/display: Add sequential ONO sequencing for DCN35
  drm/amd/display: Remove register from DCN35 DMCUB diagnostic
    collection
  drm/amd/display: Disable DMCUB timeout for DCN35

Paul Hsieh (1):
  drm/amd/display: change dram_clock_latency to 34us for dcn35

Rodrigo Siqueira (2):
  drm/amd/display: Use the SPDX license identifier for dmub_replay files
  drm/amd/display: Check otg_master pointer before use it

Roman Li (1):
  drm/amd/display: Add config support entry to replay caps debugfs

Sridevi Arvindekar (2):
  drm/amd/display: DCN401 cusor code update
  drm/amd/display: Minor cleanup for DCN401 cursor related code

Sung-huai Wang (1):
  Revert "drm/amd/display: Handle HPD_IRQ for internal link"

Wayne Lin (5):
  drm/amd/display: Adjust debug msg for usb4/tbt
  drm/amd/display: Defer the setting of link hpd status for usb4/tbt
  drm/amd/display: Correct the defined value for
    AMDGPU_DMUB_NOTIFICATION_MAX
  drm/amd/display: Don't refer to dc_sink in is_dsc_need_re_compute
  drm/amd/display: Refactor function dm_dp_mst_is_port_support_mode()

Wenjing Liu (7):
  drm/amd/display: use even ODM slice width for two pixels per container
  drm/amd/display: add odm_slice_rect parameter in spl_in
  drm/amd/display: reduce ODM slice count to initial new dc state only
    when needed
  drm/amd/display: remove dpp pipes on failure to update pipe params
  drm/amd/display: remove ODM combine before bandwidth validation
  drm/amd/display: use preferred link settings for dp signal only
  drm/amd/display: make ODM segment width of YCbCr422 two pixel aligned

Zaeem Mohamed (1):
  drm/amd/display: Remove dcn32_smu13 duplicate header

pochchan (1):
  drm/amd/display: Use TPS3 for ALPM on Specific Panel

winstang (1):
  drm/amd/display: added NULL check at start of dc_validate_stream

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 589 +++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   9 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 248 +++++---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  29 +-
 .../drm/amd/display/dc/basics/fixpt31_32.c    |   4 -
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   8 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.c  |   2 +-
 .../dc/clk_mgr/dcn32/smu13_driver_if.h        | 108 ----
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  90 ++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  67 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   5 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   5 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   6 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |  12 +-
 .../drm/amd/display/dc/dce/dce_mem_input.c    |   6 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  | 124 ++--
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |  35 +-
 .../drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |   6 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   2 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   2 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   2 +-
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c |  10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  14 +-
 .../dml21/src/dml2_core/dml2_core_shared.c    |   4 -
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   3 +-
 .../display/dc/dml2/dml2_translation_helper.c |   1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   4 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |   5 -
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   5 -
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |  11 +-
 .../gpu/drm/amd/display/dc/gpio/hw_generic.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c  |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   5 +
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  85 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  85 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   2 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   2 +-
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   6 +-
 .../dc/link/protocols/link_dp_capability.c    |  46 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  24 +-
 .../dc/link/protocols/link_dp_training.c      |   8 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   4 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   3 -
 .../dc/resource/dcn35/dcn35_resource.c        |   7 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   1 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  32 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 157 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   5 +-
 60 files changed, 1226 insertions(+), 700 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/smu13_driver_if.h

-- 
2.34.1

