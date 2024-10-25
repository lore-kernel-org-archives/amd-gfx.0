Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3362FD1039E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2283E10E9CF;
	Fri, 25 Oct 2024 02:36:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P4dqKuXY";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24B4C10E9CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+C/m0DehQ5Ht3PiGkXcM6VArHMxv/aoBnXS7V8AhLU+uqJzKTvU3ntwSGt3gk1GgWNWIsg6u5lheNHL/9y4gHBolcP9bzKKNnJ6Rpz9JdnaL2goe9zwJjSE1+Nvw7lZPpGWGRK2ZxwraYu/OLvWp4gxjW3mm/CFSyfwr1pc9KxWZS6/8xtmzVRRDEoxcbCDkw55IVvcEaqFTc0xqOhtIJpmeAOzXE4LmDJzzFgOmlMRp2DOwAu3q5Qpb87G4ahuwRzO9w+RgUzF5nOeI5P2CiLOjl69ygVFvlLd6EfmM6mw112+qixedSpIN1d5UGaaL3seBnh04EQH8jQ1W94xbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AA2SlyY4GdX1lOjTJsadXwvE73QcSsSsqaf0bvj24uU=;
 b=u8130taXHR2tsXVERgvUMnIiE6swNk2z0egziP8vmXqTU/yboVh+ESEHKJnpySiWnnbVlrh7zycEba/0wcQWCrWGxgMqwngI2pSPc7rcEW5fv5RHRWfyMUIz6T7jsBndj6rORv/RaWGC97iRzCMWpAdyLhUqdzYtp6v0nc5jsRIQrfYGUK68hd73W95WhFDUlmPcxONDyXlHWyhwDGwY5aP9SURzoHp2OM0wJHEVuNV6bWylEdNvTyE+jNrGOqeGUnm7jl3z8NBFSFd26arbW2H9wPkMxvUqo8/Si50WAsqH6CuHS1me0A9aTNRn0ytPnbI4uS2UWwdmpd5zaoAjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AA2SlyY4GdX1lOjTJsadXwvE73QcSsSsqaf0bvj24uU=;
 b=P4dqKuXYqdxCOb05W8FAsOnCNmCWfDHbWlhW3shKyJ5QZD6ddBrDepjcEx9gnqnKwdAohFG0ISkWz3VxQbto59UeaT7IO+Rbug2k7yi2wAQ4cYUwKy8SGYUN3DqE1fMKAqTDbW3R2e1dl7o20n0oPJHKIqUceUNxR8OQc44uoTE=
Received: from CY5PR15CA0163.namprd15.prod.outlook.com (2603:10b6:930:81::10)
 by SJ0PR12MB5662.namprd12.prod.outlook.com (2603:10b6:a03:429::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 02:36:03 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::30) by CY5PR15CA0163.outlook.office365.com
 (2603:10b6:930:81::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:02 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:01 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 00/29] Separating vcn power management by instance
Date: Thu, 24 Oct 2024 22:35:16 -0400
Message-ID: <20241025023545.465886-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SJ0PR12MB5662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c27996e-fd85-4175-aed7-08dcf49dc4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SkpoeVZPeTR2SG42eHdRTGtoUERzRXZGdDlxY282em9TdFZ3b00rVWNJZFpS?=
 =?utf-8?B?TnlXVGgwQnJTcWg3SmhlU0IzSCt0dExPT0xMbDBUUGo3K1lzVCswMnJoOEZ2?=
 =?utf-8?B?NHJUeWx1Rk9MamxkaDRVN3d0ZFNnbFFLRU02QkxXYktTSUtLMlBvVTEzWW5S?=
 =?utf-8?B?d1h5bE5LUWxDSTBiV1NKcysxNElGL2l5VlYwd0oyUzF3V0o5bXNsU0tSK3p0?=
 =?utf-8?B?d1BaeU5TUjRpeStqVzhSVTM0eld3b0FUbzFNNCtzNlUwNjQ1bXhxOFg0cHN1?=
 =?utf-8?B?QlhiU0FpVUFoQTZWdmRIZW9yVS9BWStxNmd0ZjdoU2luTkkwSDBSUFBad09w?=
 =?utf-8?B?MG5lU1VEdTFmUUpLVWtJOWVqUTNBdUpRQXhteG81NDBLeUVkWGhHQUdMbUh4?=
 =?utf-8?B?RDJYVllrUW1qK0hoQmxnZGFQdndwdGRpZUtGR3pYeURDVDJjR3NoeGRsY29x?=
 =?utf-8?B?Y2tQSFV0RkMxRjBiS3dTcXN2REpaY3VmaEc0NU1aWFljN3JkZ2ppMnZQOFli?=
 =?utf-8?B?VkgxMGVIdURYNC9Mc0hUSUllZGNHMW9vdmZUdERMT0NUTVkxdHNMdk15anlP?=
 =?utf-8?B?MXB0ZVJiTnFRUGE4aGFCTnMyYnYzNEZTcVBMdUJocklyT3ljMVFObXFkWG9n?=
 =?utf-8?B?N0tMTWIrMkl3a1RqZ29naGdLcy9rUFFRbnB5c0NjZjhDRVFsbzhjNm41N3Np?=
 =?utf-8?B?MFZFeFdpcXRsVlhQeHNmWHNFNE5KczZTdHlGSU5WK3pOYjJueTI1WVF3enJz?=
 =?utf-8?B?czZVVDRNazJYaWxDeThYSERzNldkUGR1Uy9BeldqbXJickJscEdKUGQ4ZklC?=
 =?utf-8?B?Ni9DdC9DaTIvRmJvK094V1FJckJ5Smtod3g5S0k0RndhR0N5TnZYUG11UWEv?=
 =?utf-8?B?T1dFZTk2OVREZGowbWR0TnhyRjZsSkx5amJESXdtOWtSdEEzY3hrcFZoRFo4?=
 =?utf-8?B?STdpVjBKVFZGeVdEWmhQODk2aVhjdU9PZE5lV2RYOG8rWXEwRmx1U2pPQzVE?=
 =?utf-8?B?TTEyZUVwYmdCajlRUjNFWSt1cDFPLzlPdEw5d04ycnd3WEJJTDBtOTg1cXhH?=
 =?utf-8?B?MGp1SHBjbG54V1dBdHhMaVRFMFVzbnd3alp2Y0FTdnpzTWNGVVR3N0Evdkxi?=
 =?utf-8?B?NlIyVzhET1VRZU9KaTR6VzJtNWNlN3R1cjFuWXB3M3o4d09uK0Z1ckUxMWNJ?=
 =?utf-8?B?VktOR3RmTWsrZ0RIbGZDZTdHTVpmRjlhNjNRajR0UGIvc3habmxSYnlqOUdP?=
 =?utf-8?B?M1RoVDZYblRXSG54OVkxRXZTR3FOL2wyaTFoWmtQbUsxR2hyMjUzcVcxM1lS?=
 =?utf-8?B?L0VEM09sbTN2WUtieGVyVy9WdHhoMXdtL1dZTmNQUFFtWFlud3dOMk9WZVg1?=
 =?utf-8?B?L1hCNkhuVWt3MzdMYUpLR1RRZVZlMjdUWjNsa0JHYmFSSkFyUExKNTdLWHJL?=
 =?utf-8?B?V0kwNWlPSjB5N0NjemU3ckdyVFZNVDl4SDBjYmI5VXdTSm4zOGVDalQwWndr?=
 =?utf-8?B?NlpDSVdnWEVPaDF6SGNJTWthSjFNWHcwNGplU0swUHpWRklDSVFOMHVYTXQ4?=
 =?utf-8?B?c1JTV1dqem5WbWJxSXhxbXUrWVlYNXFJNDQ1WEp5d0cvQnAyRjlEeFovYk9O?=
 =?utf-8?B?N0tlVnFkQzIvZkhLZ0VLdjhRNVhEM0gyQW5IQXZvblBYTTVBWTRIaUtGc24r?=
 =?utf-8?B?Q1ZUbk1CTWpTOFBUaDBkdXRia2RKU0pvTkxhWUg3ZUJxcldYbVd5U3VTUkRH?=
 =?utf-8?B?MXF4T0VYeEJ2VmRiUFY2VWsyY21BNk9XK1ZuWGR5bFFSM04yWVlDQUtCVXRx?=
 =?utf-8?B?RS9UYkZUM1FwYnZsNUc0SEtPUEtEem16ZDhDd1M2ekJpYWx4UnNKRXVHTkZ5?=
 =?utf-8?B?Sm1LYlQrYjJvemVlTzF6d2JsZktIUVBkV1ovNnhaMm1obUE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:02.8256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c27996e-fd85-4175-aed7-08dcf49dc4e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5662
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
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   55 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    3 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   16 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |    4 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |    8 +-
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  |    6 +-
 .../powerplay/hwmgr/smu7_clockpowergating.c   |   12 +-
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |   12 +-
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c |    6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   65 +-
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
 113 files changed, 3030 insertions(+), 3012 deletions(-)

-- 
2.34.1

