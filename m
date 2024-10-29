Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7AACD3A678
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Oct 2024 17:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82A4410E39B;
	Tue, 29 Oct 2024 17:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ehbBvPBs";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E04810E397
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Oct 2024 17:43:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO2gMVAAArDzbhyCTM8/Hcae0YEpvQ5afV5rQZWQf3AStboyMbi2wYDFkXJSE4NmYaJGqI4b4Y8Yqfq2PhZeZH0DQ+Q5hpPFnrHBMXBRbKxlvGH90mihB00nzJVd131vNb0GxB0413J6niRGwSOVKFlXqxZ5LcmS0g9cJitcISvDEBYZBVxVrFSDIjsrv8lahT6WdV7ckgmK6MjSmE/x69Zchi1hNBtZDZ8KoKInKM5SCQI2YEvWiakhnlAVEnQW+9LZfGJkUbi4z9iNKGiPJsmfNp03xy/KeuSjTIMA0siWvlBInoLumP4t1e0kRzmjY/fRc3SibBA4qb5tkKwNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ole3/p+Sw6T1aRpigoqOFPJVgAguCvB1Af64ejRQzcU=;
 b=C6RrPQ7+g7sxE6NI5qcbJ+E/vFQdRo03iNvbpfqUQ2oETvGGZcUtwuVCcW3Llygz6V9Yak/SQ6U1CGIbBsUOQy1bh6Ua+UlW28OdnCed0Dpr0Dt81TxF5okioHgA0EWXoKZX0WHUH+IytZ5ugCeXd2JwwmzeFMv6AqhcjQAN8f/wfkQyVlzwmdPLfhbSLzmutJAQrCHm82G2adbYy8PB+I3HYXkKQqdy7o1FEfAUsBb6noEhyoHUf0itienhNXycO6Nm/3FneTGx2HD8MN+tlX3w2eDqbR/PytzsDpsFHcP1DntEng5m7mplZ2D5bVHjcYueiji5K9Bmw2pLpIenig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ole3/p+Sw6T1aRpigoqOFPJVgAguCvB1Af64ejRQzcU=;
 b=ehbBvPBsea1PPI/RGGMjz2DSOIR3SfBU5a3w85UJPHP10jz+o0vkzOkTne/LPTITBSyswna+f6wP08x+t68ynyFmUAT6JzSW/XpsVPXvn4LKU2C/FaIWoRdqE8Bhjhm26dNjCs3moIAdzwrYGleLwKCYMMIlySAp9D9o2y0r7OQ=
Received: from SA9PR13CA0123.namprd13.prod.outlook.com (2603:10b6:806:27::8)
 by LV8PR12MB9335.namprd12.prod.outlook.com (2603:10b6:408:1fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 17:42:53 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::6d) by SA9PR13CA0123.outlook.office365.com
 (2603:10b6:806:27::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.15 via Frontend
 Transport; Tue, 29 Oct 2024 17:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Tue, 29 Oct 2024 17:42:53 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Oct 2024 12:42:52 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 00/29] Separating vcn power management by instance
Date: Tue, 29 Oct 2024 13:42:11 -0400
Message-ID: <20241029174240.682928-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|LV8PR12MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: c481257f-cc44-4ba3-ee59-08dcf8411d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QmZMb0NFV0cwR08rMHJiRTEzZStoYlZmWnpqL05sVTl6YmUrREtQMW8yQ1RK?=
 =?utf-8?B?b1lRYkZCNUlXSzBBR3BFRTBySnBoaFdRejFXejdWNVFieFlsZW1JWFYyV1lF?=
 =?utf-8?B?QnNDVVEzbExBcmMrTTErOEJLaVZjUEE0dHdEcXl1T28wNVVKUnZ0Q2kwSWN3?=
 =?utf-8?B?WXRpL1JiWXJBYUJrb2lsV3dXVVlzN0YxS3JSRW9VakpjaUlqbHNzaGlKSmdu?=
 =?utf-8?B?V2hBR3pTdHBpdU1mVDFtTE1wY3hoeS9kTElqSFNLMTJOWjFKK1VRc3lWdHdV?=
 =?utf-8?B?TzM1dERSb0JYSERNZ1RNU08veFdBaVR5VTZUaWRnMVIyb2M2ZUFwUURqU3Ux?=
 =?utf-8?B?SHdlcHpPUEVhc2hPeU0veEI3YUNOWm52VjFQemRWMUFNTCtRQUQ1NlFQRGhx?=
 =?utf-8?B?VVMwTXRHblluenFsUEE1bFNlU0ZKVlJkYnpZS3J6Z1Z2d1FycHB1aWdJa0lN?=
 =?utf-8?B?cE91RHovYTBOZjJLSWZRaDBwTDZDaUZTSGJMYW13djE0Zyt2b2FTUG45bHlU?=
 =?utf-8?B?YmV0c2RaVEJ0T0l6cGYvTWR2V3NoZElLK3dxb29jRUxublQ4bVROZ3hScUdE?=
 =?utf-8?B?Z0VoTjYrK01EM1RiQmJMVDhBSjVtZ1RDeTRyVXd6MDBSRVlVZGZYU0tjbVZV?=
 =?utf-8?B?bXRqdlUyTUFnN0ZtUVd1cjh1TG9rQmFBTEFkeE5sZG1RSVprZjZSdjMvdWtw?=
 =?utf-8?B?M0d6ZWY1UU9RbTZHd2krY094RElkT0JlOTcvUTNYNkg2T1FUOUlhS0xuOGQ3?=
 =?utf-8?B?NE9zOGlOQk1oRHExWHBId0NGYzl1S2MrTTRMLzJUNy9NaitqMWhFR3REMzZM?=
 =?utf-8?B?VTBncVVXRUhUck5ZSS92ZlkzMnduU1pad3FmcXN4akNUNnUxcDR1Rm5NZGNM?=
 =?utf-8?B?eXcrd1BoSVFtMW5tbm85TlNNWUJSbFVLMWFWVWlLZVRiZ0l3WGRkMUJuRWNh?=
 =?utf-8?B?NHh4TzVaNkhtTEZQOWpFREFRNUtVNkY3ZXhpSHkwV2N5d1NzYmxCbHozSGJ1?=
 =?utf-8?B?eldqOElMTTVMNEwyR0pmQVlCVU02Z0RqbFlVaTZrUEV4bnUwNXhZbG1RQWRV?=
 =?utf-8?B?OGFuV2l5YkJ5aFhKN0NkeEhNbXByd2pmeXdEM1JXdEdmbVJRL3I5aUtLS2dK?=
 =?utf-8?B?TkZhdUVSaG5aeWExeFhiTDJRbFgzeER2cWJ5eFg4K1J5M0E3S0w1eEVxRms5?=
 =?utf-8?B?ajc2Z01uVkdacU1QTUNXUnZyZDN1clllS0RNNTRuMVFSNHE0NDg1QWJncVJD?=
 =?utf-8?B?ZUZ4dnA1eXNXajJsSmhEa3VJZ2d6M2pPYXNhbC9NcE5PbUFCbFYzZWJOSFVn?=
 =?utf-8?B?NHJ2MDU1dzFzdExadjhqRnlVZ2s1eW5IS2hHMHZnZGsrSnVlQlFBZE85VVJ5?=
 =?utf-8?B?MVFMdkp5Mng4eFBqUE8yMXNXTVpJaXBBUG80c0FQL1FuRWg4UG1tSk5wbU0y?=
 =?utf-8?B?ZjIyVzFRVnMxN1NraHk2ZlF4MkluQlY1ZlNCbzgySTFjK3BDWWU5SVM3VXJD?=
 =?utf-8?B?N24wdVpIeHpuT0FtTXhoTnRBZWFjZG1nS0luWjdTUmZqUklBR2gzOTU1dk9O?=
 =?utf-8?B?Y2NoYW9CZ3RVWUtzNDYzU2pYdkdLbG05SkRUOVBiYk44THhZanJ3SU1kcGxz?=
 =?utf-8?B?dGwzVkxUdjJtM05vVFcyQldydHR6cVM1QWhBMisvOWlPN29tcEY4djFkdlJq?=
 =?utf-8?B?Vm1PLzVDNStUTXVCOFJqY1F2dElMRlhEbXhFaktHWWNhUG56aUpXd0RMZHpG?=
 =?utf-8?B?RmRaZmdhaWpobkRxWWhxL1BjbWxiYmhpV3J0OE42eEpQbkwraHZ5T01JZGFJ?=
 =?utf-8?B?M2p2a2p0V0dpRjZ3MDM4VTc4UTI4ekJ2Q2g1dkw2SjRSQUpEU1FLeHl1MDAx?=
 =?utf-8?B?cC8rc0FYa1h1djR3R1NXYU1PeWlmcXJIeERwVHZhNDNZdmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 17:42:53.0996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c481257f-cc44-4ba3-ee59-08dcf8411d87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9335
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

v6:
revise patch #3, #5 based on Alex's comments.

add reviewed-by/acked-by and rebase patches.

v5:
revise patch #6, #28 based on Christian's comments.
revise patch #7, #8 based on Sunil's comments.
revise patch #24 due to Lijo's recent commit.

remove patch #28, #29, #31 in v4 based on comments.

add reviewed-by/acked-by to patch #1-#19, #27, #29

v4:
code polishing and minor fixes.

v3:
move all of the per instance variables from struct amdgpu_vcn to
struct amdgpu_vcn_inst. (patch 10 - 11)

update amdgpu_device_ip_set_powergating_state() to take the instance as a
new parameter, remove the duplicated function in v2. (patch 19)

update all amdgpu_vcn_* helpers to handle vcn instance. All functions
are now only handle the given vcn instance. (patch 20 - 26)

update all vcn ip callback functions to handle vcn instance. All functions
are now only handle the given vcn instance. (patch 27 - 32)


v2:
complete re-work for all PM changes as suggested-by Christian König and
Alex Deucher. Adding instance to all existing functions, instead of create
new functions. Remove all duplicated PM functions in previous patch set.
Use a new logic to track instance for ip_block with same type as
suggested by Alex. Also, fix wrong ip block index and remove redundant logic
suggested by Christian. Finally rebase all patches based on Sunil's ip block
changes.

Previously, all vcn instance will be powered on/off at the same time
even only one of the instance requests power status change. This patch set
enables vcn to ONLY power on/off the instance that requires power status
change. Other vcn instances will remain the original power status.

Boyuan Zhang (29):
  drm/amd/pm: add inst to dpm_set_vcn_enable
  drm/amd/pm: power up or down vcn by instance
  drm/amd/pm: add inst to smu_dpm_set_vcn_enable
  drm/amd/pm: add inst to set_powergating_by_smu
  drm/amd/pm: add inst to dpm_set_powergating_by_smu
  drm/amdgpu: add inst to amdgpu_dpm_enable_vcn
  drm/amdgpu: pass ip_block in set_powergating_state
  drm/amdgpu: pass ip_block in set_clockgating_state
  drm/amdgpu: track instances of the same IP block
  drm/amdgpu: move per inst variables to amdgpu_vcn_inst
  drm/amdgpu/vcn: separate gating state by instance
  drm/amdgpu: power vcn 2_5 by instance
  drm/amdgpu: power vcn 3_0 by instance
  drm/amdgpu: power vcn 4_0 by instance
  drm/amdgpu: power vcn 4_0_3 by instance
  drm/amdgpu: power vcn 4_0_5 by instance
  drm/amdgpu: power vcn 5_0_0 by instance
  drm/amdgpu/vcn: separate idle work by instance
  drm/amdgpu: set powergating state by vcn instance
  drm/amdgpu: early_init for each vcn instance
  drm/amdgpu: sw_init for each vcn instance
  drm/amdgpu: sw_fini for each vcn instance
  drm/amdgpu: hw_init for each vcn instance
  drm/amdgpu: suspend for each vcn instance
  drm/amdgpu: resume for each vcn instance
  drm/amdgpu: setup_ucode for each vcn instance
  drm/amdgpu: set funcs for each vcn instance
  drm/amdgpu: wait_for_idle for each vcn instance
  drm/amdgpu: set_powergating for each vcn instance

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   20 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     |   13 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  341 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   26 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   14 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |    4 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |    4 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |    4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |    4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |    6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |    8 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |    8 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |    8 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   14 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   16 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   16 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |    6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |    4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |    4 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |    4 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |    4 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |    8 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |    4 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |    6 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   19 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   19 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |   76 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |   60 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1077 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  832 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  720 ++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  646 +++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  695 ++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  609 +++++-----
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |    6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    4 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    4 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |    4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   41 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    3 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   16 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |    4 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |    8 +-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |    6 +-
 .../powerplay/hwmgr/smu7_clockpowergating.c   |   12 +-
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   12 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |    6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   73 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |    4 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |    3 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |    3 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |    4 +-
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |   24 +-
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |   19 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |    4 +-
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  |    4 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   38 +-
 113 files changed, 3020 insertions(+), 3016 deletions(-)

-- 
2.34.1

