Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AD9CF0427
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 21:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7281B10E252;
	Tue,  8 Oct 2024 21:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EMYJZ6Um";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9CF610E252
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 21:16:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8fUcLxLGZ9ztU3WcHGeghm7n4DRJsycl6l75XkaLKo5lPPa/Oc+AWZpquH5lybPmBQB6psiIzGA5xko7gxnnZldCrtsn55FAFD2fXS7XiGcibcw3IOi28y2hIi520VTUlH5LHget8nqMnB866P12adqvaZ6SF3sHQY//LEus/L1m+LqGpdobPdMcG5s6xvE+aHqK0/7+n1cSFHnlO8M8u9wo6pOGQy2hcb2iB9sqNTPIGv+3m49mCXRZJ0QsBONGm/zOutCy21/yBV32DyLL4sqflRfmg84S+r5+ncwFrCWYEViRHUUa0szSkRHQoUCqY2jfkZuIj3MHg+kTCGvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DkGzTPFfvwkLljj++I16eXU/reFCQbsVIdfyfItojb4=;
 b=aucGyX6UtRhYwun72Egmd7BJZnbN/luJ872QyDyGuPdccBQtpO2gcxEROfE8ka4wXFchZsxaB/l/ZGL1J4+dsKPqTSYjLSgcJEserb0rLXZQwJQvXBKJYcTSxfW5HaYMfx/BdvN3j/jH9sXxgqSXVtDtcGIoBz5L76ipeLry0LRTjWe242fjr34TDdj9yn+naE5rpckJTbm7dXdZOXiWopQ6ZSfxAZCk/wt7jv7XlHU5vp+ycbyUFVwTApOPoVYHJv9nSeQ7gYG5PqfdmXnqM05b7r0qHO1wRIpHJnmI25g0JZPB7n/tAze/bVJcIQOh+JZEb7bUbIJQX9PQvIHgJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DkGzTPFfvwkLljj++I16eXU/reFCQbsVIdfyfItojb4=;
 b=EMYJZ6Umj1A62qb4YNg/Bxy9i3dmTBxOYC6avf6O2K7mvJcv9DclLJ/P7IelfO2MfT8cXLrzzBYH+IXXRdPhWbONvYOJNa80u2Li963MkHvIxVEqQjkqiE6m/a5POOu+Cfm9sDF1uFGdW5kJAXSxMl9cPuBR0R2JaXGmR8ek+f8=
Received: from CH0PR03CA0401.namprd03.prod.outlook.com (2603:10b6:610:11b::35)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 21:16:19 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::54) by CH0PR03CA0401.outlook.office365.com
 (2603:10b6:610:11b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24 via Frontend
 Transport; Tue, 8 Oct 2024 21:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 21:16:18 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 16:16:17 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 00/32] Separating vcn power management by instance
Date: Tue, 8 Oct 2024 17:15:21 -0400
Message-ID: <20241008211553.36264-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbff175-f89c-4469-7d9f-08dce7de73cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0hXcm05STJQWnVlYWp3U2QzSUxXZEpjSjVUbnlWdVBabngwajk5M1JXdmww?=
 =?utf-8?B?YVphbWo2T0xUeEwzMGZXVzQzdktrQnVCQTRycGlSOS9TcFhjZ25ZWDBsTDlF?=
 =?utf-8?B?bTZFa1JtWUtnTnlQK3VvY0plUGRYZVh5WFdSMDRybVBnMUoxSjc1U2ZZVHZw?=
 =?utf-8?B?RGJTQWRCdk9yQTlFbXl2MDV2OGRzR1dwOXFBVkJGVlRRbWtQS1FERExFV29B?=
 =?utf-8?B?TC8zTFNUdS8zV1JnNHFkcUVuM2dDZW90NEpQemRnVzYxbGNoVzBqMXhmUVIv?=
 =?utf-8?B?VDhFaG5RMjYybHhiY3BEUTBZVnRyL1l5SmJDWk5uZnkwRUdkYjlPK3FhNXcr?=
 =?utf-8?B?VWxVb2N0NTNGZDZJUkt2Q01EY1A5bk9MRlN5d2xDYmIwcDROYi9TenNtY2Ey?=
 =?utf-8?B?bHpSc3JnRGdtMUxTL0NDbVpkMmplUlFsU3Q3QlBoODhFV1VtQmZrU3REWENw?=
 =?utf-8?B?SU9rZER0YWwvUG0yTnFyWjYyTDV1cWtsaEZSRWF2Y29FTkRiUnd6byt0eXlK?=
 =?utf-8?B?QlArQlBLZXEvbGk3WVIxckZxS3hCcm96YXQvakNDU3VVOFNmUFBVdzRKMGpz?=
 =?utf-8?B?bFhVLzR5OXh6VklNZG13bnEvaEdpZHBsdnhabnhWVFdpZzBFRFFtRlZrWWxK?=
 =?utf-8?B?RHZ0NHErOVp0a2o2TWdvb0hLaHppWUVXQlpDU0FPYXZIa295WUdUUkN1dmVu?=
 =?utf-8?B?dzNaYWJjZDBUakR2dDhrMTk2QmlRUHFYZS9YKzdXcW93M2pDSm41dDA3VUU3?=
 =?utf-8?B?L3hzT1hQREJONzV1RUlOQ2JocVZnRFh6VC9aVWpET1dqbmUvSDl2T1hiU01C?=
 =?utf-8?B?ZERyMHlOek1lNlZBaW9adExNSWV6czV0R21OOExsU0RvRnV0Z01yMit5TFls?=
 =?utf-8?B?ZVBicHNmdjhJelg1aDdmK3hhbTNoa283dUFQZTFyNC95NjNpZ0pDK2s2dlRs?=
 =?utf-8?B?cEVTbUFvQjVBTEJZME5iejlvTGQ0RGpHZVVKK2lqWXYwcXlkMFVhbTQwNzg5?=
 =?utf-8?B?ZVF2ZXM1WWZVK0dxZFlINmQ5b2VZUW44Y1FUbGRCYVdXcXF3dlphNGVTOEZJ?=
 =?utf-8?B?R29RcFFodFhMbHV1SzRqZTJjZEJmdWEydmw2S1ZQRWVtRDN2S1EwN21SZWNl?=
 =?utf-8?B?RFM3S0dSS2I2L0VZdFpBZkhGZ0loMEZ2OFR3K2QwUlUyOTEvc0hWU2VWVW5s?=
 =?utf-8?B?R1YxWCs4VEZCWkRhM29Sa0J0ZUpVRzd1NElGYXcwNkliK2UvbHVoYnFPbjh0?=
 =?utf-8?B?U1l1dmZ6cWhoSGI2U2hPOVhXaHNYNzlQdGRpbjBObE96a01RR0FoU1lBVnBw?=
 =?utf-8?B?SEF1SVdJdXNlL0ZwK0xKOGxrQmVHd1hzVFJxblR0WU4vckZNTWFyUXBnbU9q?=
 =?utf-8?B?ck5Id0NBRzJKNWRJaHNrOEs0QXNDNllhK3RzSm14Z0VLeWo2SzZ6YU1TMEYv?=
 =?utf-8?B?bmFmSXlmYjhhWnphR2JZY3B3dFF5OFdVVHA5YXV6L0hxajBsTmt1UWxVMTJo?=
 =?utf-8?B?dlBMemF0V0xMNE9OWEFzRFNYOTVWV2NIWW82Zkc3bDM3WnhLbUxyb1dCMFY2?=
 =?utf-8?B?S0pudkVGRk9Zb2xBb3FDTXY4Z21DaWtkZ093anZCNjNoOWd6YmN3ZjEySlk3?=
 =?utf-8?B?N1BFZEtpcjFUZkdjd2Q1Qyt5SHBMRnF3L0dxdk9uSW15aEw2TWJzamVFTGo3?=
 =?utf-8?B?c0pCMzBzNitTdklZazRjZGpHRytUSjM0bHVESE1VWVJtUFNvWXFITXFYb0U4?=
 =?utf-8?B?V241Mm9nTEZpZVhKNjMxcmU2L1AzaUlVMlpTMVNkeUdEdHBjenc5ZWR5QXVy?=
 =?utf-8?Q?DESPLgnp6tVB6ivSOFqmSi4+yhOX5bHaxfF6I=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 21:16:18.9208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbff175-f89c-4469-7d9f-08dce7de73cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848
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

Previously, all vcn instance will be powered on/off at the same time
even only one of the instance requests power status change. This patch set
enables vcn to ONLY power on/off the instance that requires power status
change. Other vcn instances will remain the original power status.

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

Patch 1-6 are SMU changes to only power ON/OFF given VCN instance.
v2: Remove all duplicated PM functions in v1.

Patch 7-8 pass ip_block instead of adev pointer for set_powergating_state,
set_clockgating_state, and is_idle

Patch 9 is to track VCN instance in VCN ip_block.
v2: use a new logic to track vcn instance

Patch 10 move all of the per instance variables from struct amdgpu_vcn to
struct amdgpu_vcn_inst.

Patch 11  VCN change to separate gating status for each VCN instance.
v2: Remove redundant logic.
v3: move cur_state to amdgpu_vcn_inst

Patch 12-17 are to handle ip callback functions separately for each
VCN instance, so that only the given instance will be powered on/off.

Patch 18 is VCN change to handle idle work separately for each VCN instance.

Patch 19 is to set powergating state by VCN instance in amdgpu_vcn.
v2: Add instance parameter to amdgpu_device_ip_set_powergating_state(),
instead of creating new function.

Patch 20-26 update all amdgpu_vcn_* helpers to handle vcn instance. All functions
are now only handle the given vcn instance.

Patch 27-32 update all vcn ip callback functions to handle vcn instance. All functions
are now only handle the given vcn instance.


Boyuan Zhang (32):
  drm/amd/pm: add inst to dpm_set_vcn_enable
  drm/amd/pm: power up or down vcn by instance
  drm/amd/pm: add inst to smu_dpm_set_vcn_enable
  drm/amd/pm: add inst to set_powergating_by_smu
  drm/amd/pm: add inst to dpm_set_powergating_by_smu
  add inst to amdgpu_dpm_enable_vcn
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
  drm/amdgpu: print_ip_state for each vcn instance
  drm/amdgpu: dump_ip_state for each vcn instance
  drm/amdgpu: wait_for_idle for each vcn instance
  drm/amdgpu: is_idle for each vcn instance
  drm/amdgpu: set_powergating for each vcn instance

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c       |   22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   41 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c       |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c      |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       |  338 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h       |   24 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c      |    6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c       |   14 +-
 drivers/gpu/drm/amd/amdgpu/cik.c              |    6 +-
 drivers/gpu/drm/amd/amdgpu/cik_ih.c           |    8 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/cz_ih.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |    6 +-
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |    6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c        |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   12 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |   16 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   12 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c       |    8 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c          |   10 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_1.c          |   10 +-
 drivers/gpu/drm/amd/amdgpu/ih_v7_0.c          |   10 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c        |    2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c        |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c      |   18 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c      |   20 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c      |   20 +-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c       |    2 +-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/nv.c               |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c        |   10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c        |   16 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   14 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   10 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/si.c               |    6 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c           |   14 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c            |    8 +-
 drivers/gpu/drm/amd/amdgpu/soc21.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/soc24.c            |   10 +-
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c         |    8 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c         |   10 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   14 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   23 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c         |   25 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |    4 +-
 drivers/gpu/drm/amd/amdgpu/vce_v2_0.c         |   16 +-
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c         |   20 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   12 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c         |  140 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c         |  124 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c         | 1154 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  909 +++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c         |  801 ++++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c       |  727 +++++------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c       |  782 ++++++-----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c       |  690 +++++-----
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c        |    8 +-
 drivers/gpu/drm/amd/amdgpu/vi.c               |    8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    6 +-
 drivers/gpu/drm/amd/include/amd_shared.h      |    6 +-
 .../gpu/drm/amd/include/kgd_pp_interface.h    |    4 +-
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |   55 +-
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |    3 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |   18 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |    6 +-
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  |   10 +-
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
 112 files changed, 3442 insertions(+), 3433 deletions(-)

-- 
2.34.1

