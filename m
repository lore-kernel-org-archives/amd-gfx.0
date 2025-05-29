Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B2EC54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 10:03:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F8B10E724;
	Thu, 29 May 2025 10:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BMf7Cwm3";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3650B10E724
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 10:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Skvmcf1oOqu73fc0U5F6aHpPOXMsSYWcgG3AdU3oMWh9TN8J2BWNwg6R3uY8ERZpmhlYGCEeUaquVLlUnIs1mW/zKLJfz0O1x0CgJInJbQzUpPajANbF9Tu2gaMWobd6ybcgYzASjwbFzqoNpZ0F2Rj5Io23lJQjTL65vUCQE7BsfYsauIz1RfmdHL0+zBudzHFEsn6yyv4zhgZV5NJ1C0j2jalm5KxQFCxtpiBl9Bsd6wf6Yn8muB+JqmI0yaeOxI5mniQvNftqaRWPbBo8GFfaU/PTNtM2RQYeIooj8a+al0GiQSjtVjJqzoycsSzJ6rU0UrRIp1RLCaSum9zJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhI1nkJxisa4M/IBigE4qm6/BWcLqRyAgbcm/k83K80=;
 b=K0FI0mXcUMuuXn3CxJBcjmrz1CFSZzq6vOmGRKukSVL9hpjRw8wNVLBGJ2eHU8e6JwIJbRmnK6hxWjboCv+zt/alfMLPEs1YQLQNjZi5rxh5xA+hngkzmIQCRQUVOqwcg+43Hgvw1MldYQ2i2aIml4IKYSfwKvEvP5IIMLaH4S2Ww6jUXN7jemWvpFYgZFqhtVMIaEBFrfOur3X+O9l74XAIGkRJYi9zzrZPkUVjVqaS6+CwmbD1sfQt1o6d0x3Crrg8ZI034skLR3Zwy9fdjD+iOEXFuffZHrpevPT9A9T2uWy7L/8qcCDtcvkWllQHVYZ7Fdp0avXtV894A/Di9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhI1nkJxisa4M/IBigE4qm6/BWcLqRyAgbcm/k83K80=;
 b=BMf7Cwm3z7QWvdF+hFnr0uA4YlnCvLhtr65mXsGLwGHUVnDALNQYR+x07sBFaulZl60iuZ4iBjr2pGdOmRmL1jj+O/Mq6Te9VFMrkKwckVrQenKtkpeEDfbCW920PwPMSErCyYZwe9eSHiOlqImRuEvYAlkv0ZCXV7TUYxr5B3U=
Received: from BN9PR03CA0428.namprd03.prod.outlook.com (2603:10b6:408:113::13)
 by PH7PR12MB5856.namprd12.prod.outlook.com (2603:10b6:510:1d7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 10:03:02 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::da) by BN9PR03CA0428.outlook.office365.com
 (2603:10b6:408:113::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.21 via Frontend Transport; Thu,
 29 May 2025 10:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8813.0 via Frontend Transport; Thu, 29 May 2025 10:03:02 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 05:03:00 -0500
Received: from hjbog-srdc-17.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 05:02:58 -0500
From: Samuel Zhang <guoqing.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <victor.zhao@amd.com>, <haijun.chang@amd.com>, <guoqing.zhang@amd.com>,
 <Christian.Koenig@amd.com>, <Alexander.Deucher@amd.com>,
 <Owen.Zhang2@amd.com>, <Qing.Ma@amd.com>, <Lijo.Lazar@amd.com>,
 <Emily.Deng@amd.com>
Subject: [PATCH v9 0/4] enable xgmi node migration support for hibernate on
 SRIOV
Date: Thu, 29 May 2025 18:02:52 +0800
Message-ID: <20250529100256.754769-1-guoqing.zhang@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: guoqing.zhang@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|PH7PR12MB5856:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d43843-be37-4722-a595-08dd9e97ffb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z3ZTQTVJZVJlcnNxbE1Cd1d1cFB2RU8vb0c1R0pmRXRBdFcyZzFUMkNwZ1BZ?=
 =?utf-8?B?eDQwQ01nMkt0d3Q2LzZLYnFjOUcrUkZKMjg3L2d0cG9VR3JwakxjcTdRWnhB?=
 =?utf-8?B?RHVhWnVvT28vbHJkREtMNHFnMFNiVDVsS0tlcko2REZLdnJlT0hwNEI3WThp?=
 =?utf-8?B?RWZHY0xkSTRSMUlSUFhCU1FMZ01rR0hRZHZlQjhQL2prVVByV2VwOVBrSUhy?=
 =?utf-8?B?aGlXMkw2bk5ySUxkOXRMcUpoM05yZjRyMW5JbzhtaCtxMGM4MDdsazRDYmo0?=
 =?utf-8?B?Z1Y2UXRIeDdEZ0NSUXdldDNQTDBLMmYyZGtNdFU4aGVEbVRYREdWdWcxUk03?=
 =?utf-8?B?M01tcmFOZFZSOURLZm5ma3JCT3BsbjNWQVAxQWFVU09qRTBnc3Jxd1puK0hw?=
 =?utf-8?B?Y2RobEZhdXZrUGxzcFY3MldTYkRacTlQV0hmbmw3dit5OFdkckFZUnFzT2Jh?=
 =?utf-8?B?bUV1OHo4SzE3NXhycTZOZTRiMnhRa2w0R0Z3Tmh2aXptWmNUdUhZN2V0c01t?=
 =?utf-8?B?NU8yOXZOdDBSKzR3NXN0SzMrWjgxWmQwODd6R3BzSzNtUWMvSXZVYWpMektr?=
 =?utf-8?B?VmZhbFFaK3F5YSs5ckJhV1phZG1IVUNweGVQeEFVVTM3SkZvci9DeVl5N211?=
 =?utf-8?B?RlFlNXF1bXN4N2plQUdOZ25qakdHY2xDc3BXeEdSRTRDUExIYkNKSXVwSXFL?=
 =?utf-8?B?ZUt1TlI3ZDhyR3pISG1jWmZ1ck1YdUpiNUZ0emVxM1AzbHZZazQ0ZE5nc256?=
 =?utf-8?B?Wk1DeG5sU1FaOVBacEpLTU04MUo0VUUwZzdJWkpoOVN6alFYKzBGUGQ4MTJR?=
 =?utf-8?B?SVRVNWdlV21FT1RuNkRFckJzWVhmYkw4cmpkMTNjSU1JV0haT1lpdUJPTlpm?=
 =?utf-8?B?QWkybkpMd2hQY0kzaGJYRWtlT1F1TmoyTm16N2dQV2F0KzQ2ZFYwczRiMnpR?=
 =?utf-8?B?eEhkRmNUZ2dyNDJXWjY3SXVaeThia1FUQzhSN00xbTVQL1JoWlAvZC8vTFZH?=
 =?utf-8?B?UEM1aU1LZDdWaFlmalJJcGkrWW1yUDlObWRucllMMFlGcEgyVzlpanF0L3BL?=
 =?utf-8?B?K3A2SElkYlJMbEVNbERRTndUUHpzV2Y3eXluK1NYOUpRb0ZFYkFmZldiQ1Rv?=
 =?utf-8?B?TzF1VEZFOUQ2QnFWc2xzS3FuUFoxajZna2lyN3l5bUUyN3FhL0V4M3YxSEY2?=
 =?utf-8?B?Sm9halU5VkJCb3dXQXhBYVdHNWEzcXNpNEljSHdSMkVtcm96OUk4YWMrcklC?=
 =?utf-8?B?WmdlZWFOUmZJWFR6ZzA2ZGhUcXJRZmppSEdVSUhmeXJwb3lEZm5Ka09kMm5N?=
 =?utf-8?B?dC93Y09yKzl0N0prejZESWd4WDVvNnc3dG5JaEZ6NVUvRm8vZnpiUlhPTHhj?=
 =?utf-8?B?OUszUll1bHhEdk93ZTdqVmZBaUQvTndJSzBJT2dkT2dQWXJvNGNVSEVQU1p2?=
 =?utf-8?B?dUxaNVNXQ3JDWDJqTGs4MklLcThQN3J4WlM0amZrTHRZUTl0Q1FGazMzZ1lT?=
 =?utf-8?B?MERBMFlzKytIZW85Mi9EQ0JKMDZSbUd2bG9GMTZiZVBTN2lZOXhiWDVvRlBm?=
 =?utf-8?B?NFI5R0VoWS83RnZ1Z1FhTjY5SDNWRythVWg1eFZ6NHp5cHVPZDBLMWM1UndF?=
 =?utf-8?B?d0RNU2xmdHBhUnpEbStkM0d3angxc1RuSW9ienhmazd4V0YyQll1ZFFYUUll?=
 =?utf-8?B?ZGpJc2wwS3kvelo2OVVnTmc0dkY3K3pCWFpsdy9wT2dhNWpEVDZLOFd2Vnh1?=
 =?utf-8?B?MjZXNTMwR1Y0THU4V05nM2ExN3ZMaEptT3J2OFdKdnpuWUxpNlRSRDFoeSt1?=
 =?utf-8?B?aDdsaWt5OFo1VWMyazIrN0RKZkJxMXEzemJneXRreFcyS0N4b2dRUmQwUXNX?=
 =?utf-8?B?eG1DeFBTUzZ2SmUwZ1UxK0hCNnRvc2NpNTFScVI1d3dUMGI2dERqZzNjWGZT?=
 =?utf-8?B?b09VYVlpTFlmOW0vYUROMFBhUDYwVHhVMC9HNnE5WkdOUmFHTHpFYjNLOFZN?=
 =?utf-8?B?QW5VWHBraklqUnpCdytPcG9CWUVyaXpPYm9wWWZLUVlwL1RweFU1WVhydWtq?=
 =?utf-8?Q?2aEXtC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 10:03:02.3664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d43843-be37-4722-a595-08dd9e97ffb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5856
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

On SRIOV and VM environment, customer may need to switch to new vGPU indexes after hibernate and then resume the VM. For GPUs with XGMI, `vram_start` will change in this case, the FB aperture gpu address of VRAM BOs will also change.
These gpu addresses need to be updated when resume. But these addresses are all over the KMD codebase, updating each of them is error-prone and not acceptable.

The solution is to use pdb0 page table to cover both vram and gart memory and use pdb0 virtual gpu address instead. When gpu indexes change, the virtual gpu address won't change.

For psp and smu, pdb0's gpu address does not work, so the original FB aperture gpu address is used instead. They need to be updated when resume with changed vGPUs.
v2:
- remove physical_node_id_changed
- set vram_start to 0 to switch cached gpu addr to gart aperture
- cleanup pdb0 patch
v3:
- remove gmc_v9_0_init_sw_mem_ranges() call
- remove vram_offset memeber
- add 4 refactoring patch to remove cached gpu addr
- cleanup pdb0 patch
v4:
- remove gmc_v9_0_mc_init() call and `refresh` update.
- do not set `fb_start` in mmhub_v1_8_get_fb_location() when pdb0 enabled.
v5:
- add amdgpu_virt_xgmi_migrate_enabled() check
- move vram_base_offset update to pdb0 patch
- remove 4 refactoring patches to remove cached gpu addr
- add patch to fix IH not working issue when resume with new VF
v6: per Lijo feedback
- rename amdgpu_device_update_xgmi_info() to amdgpu_virt_resume()
- merge xgmi node and vram_base_offset update, IH fix into amdgpu_virt_resume()
- remove 2 unnecessary gpu addr update changes
v7: per Christian feedback
- remove pdb0_enabled and add gmc_v9_0_is_pdb0_enabled()
- remove amdgpu_gmc_vram_location() call in amdgpu_gmc_sysvm_location()
- remove check in mmhub_v1_8_get_fb_location() and update fb_start/fb_end on resume
v8:
- use cached fb_start in amdgpu_bo_fb_aper_addr()
- remove fb_start/fb_end update in amdgpu_virt_resume() and amdgpu_gmc_sysvm_location()
- use vram_start to set regVM_CONTEXT0_PAGE_TABLE_START_ADDR_*
- move check to the callsite of amdgpu_virt_resume()
- add gmc.xgmi.node_segment_size check in amdgpu_virt_xgmi_migrate_enabled()
- rename gmc_v9_0_is_pdb0_enabled() to amdgpu_gmc_is_pdb0_enabled()
v9:
- refine comment
- move amdgpu_gmc_is_pdb0_enabled to amdgpu_gmc.c
- refine coding style

Samuel Zhang (4):
  drm/amdgpu: update xgmi info and vram_base_offset on resume
  drm/amdgpu: update GPU addresses for SMU and PSP
  drm/amdgpu: enable pdb0 for hibernation on SRIOV
  drm/amdgpu: fix fence fallback timer expired error

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 38 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c    | 33 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 20 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 23 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c  |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  7 ++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   |  8 +++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  8 ++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    |  6 ++--
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 18 ++++++++++
 14 files changed, 152 insertions(+), 17 deletions(-)

-- 
2.43.5

