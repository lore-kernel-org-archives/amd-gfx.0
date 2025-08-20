Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9730CCA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 11:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A06D10E6F6;
	Wed, 20 Aug 2025 11:33:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dlno6vWy";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D65F10E6F6
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD6J46HgxRR6ERvXErCgOUSXflRDWfFYwU/PSfbh+n/NOFKutSk+TZnUAHKOPRJRs3LL7VK7RLjmGjfIDUxNudydKJJ1741WS+ISK6aHYzAtZ1WYQxbXqxQfvctvFD0eEuHXQrqQJiSF3ijjr0CQpFLkMgP3NYiHiWAk9PAJAh4xeih5mLEo2IQVYqs88Owhjkh/UBUbnp5+D5BUsNmn9gGjTTwBOlkG2h8WJgUTbfM7vQ4NUdHs2FIufDpI3dD8nazoj9Re0UC8W+VeQ1XPDViwzMskFF0FwHWxDmG4FjwkwZVSLXNri7wiLkHt8EiFfXss8CuOnGIAduoSWdWQ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubMhxWTL3dVaHUwmMfD2vrGXOIfPRndFpWBI1JPbixU=;
 b=fRFbqs8VOMmMjeSmT0MIApjqPzTtcKzM72RgATLlD2r6YuaIDpaRXNsJLopKPyngNDuAfmzeK9zYoE3sEjRLgE+GWa/F+h/wLAxC11j2o9ywJsJnpQpy7bD+dqiOtpoYJTTHyyRs8cdjnaFFM4JukPyAJb9BZXw33BEzbBAAmLJGLP1OTSfMRdEChpR61Nki4RC8PWuAXk2GrHfwRm+UWM+sn2deiHWWt95duBkhmrn0JkFXKX7UkmjVnhL3dklvlEBJSAsHDar32aCXwInxxDdQClYxXXqMv0fOVg7z6sN2jIs5kVKTAzUU78+Co4AU48+jVCsc03et/KhX6E+3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubMhxWTL3dVaHUwmMfD2vrGXOIfPRndFpWBI1JPbixU=;
 b=dlno6vWycdCPJizHChdg7x7ERpWi2x5/0mf0uvjvIegviX/k3IpErv1dUrlNakOfZ5AOp2ruIYQtoLg1hCsSLP0SDQ8EDfpOe+cZKRM2WbOAqVpCwg1PXG0E/RuCsvz0bLCodik6gQc3KW9p7k2SLGYGX7/otFD1LvapYupvwys=
Received: from CH3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::7)
 by MN2PR12MB4048.namprd12.prod.outlook.com (2603:10b6:208:1d5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 11:33:23 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::19) by CH3P220CA0005.outlook.office365.com
 (2603:10b6:610:1e8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:33:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 11:33:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 20 Aug 2025 06:33:20 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH 0/7] drm/amdgpu: add MMIO-remap singleton BO for HDP flush
Date: Wed, 20 Aug 2025 17:02:47 +0530
Message-ID: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MN2PR12MB4048:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d3183a-5ac9-4dd2-1b34-08dddfdd5f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUdKZXJIRGcyMVUvMXJxS2ZrU2NFZ0d2MnMzU3Jva3dvaEs3N042Yi92K1Np?=
 =?utf-8?B?ZVVkb2NjT1NObXEySkh1aGo4d05RMFBsRjF0cFpMMnIzeVdUd3pCelFWTkZL?=
 =?utf-8?B?Y2paZjBZYmtKR3JFQUlOMEtna1NPUDZ3eFhramhuak02eXpUTzFtK3FHTVls?=
 =?utf-8?B?TVdqODRFd1pzUmZLZkRuQlMxYU1MTVdvMVVEWm5IbWlVdjFzV01ESVlyZjNo?=
 =?utf-8?B?c0IyOG84TjEyZk9VWkhSUWlNc3daemppZFZUb2R3eXNvd2hDaU1lb3ZZMWNs?=
 =?utf-8?B?REpnZjJTWnlNanBIdnhJWit2THNFVWlSUzFYVHRuQ2NoU1I1WHZIbmFlWHlU?=
 =?utf-8?B?YjlZV0E4djc0YWRnc2w5bFdETVFuMTdOS2VEb2l3RERod2lrd1lnWWhTMmVR?=
 =?utf-8?B?SHFYQzVaeFYyc055UlJBbUVFTk5QaVJOUVJydzg0dC90TVRuelplbS9ZZ0c0?=
 =?utf-8?B?QWUra245bUhSWlB4REFHaVV3bFZCaEVSMHBmNW9qWkY3NWl3YWZOdmRkWHJq?=
 =?utf-8?B?aS9oSk9YTW96YlhCNUI0REJDdXF3UllJSG02UFRBWmJOc0xpTlNLNDhXQklQ?=
 =?utf-8?B?b2wvcmx2aDJSdWdTbHEzbXRzU09IWGMwL3BKVlErbjQrbjNGNXdxVGpORGw0?=
 =?utf-8?B?QmZBazQ4enJ1dk5FeEVpNktOelVEUjNyRWQ5d3UycXhTZnNCZ3I2YTVkeW9U?=
 =?utf-8?B?RW1JdU1EeGNjVDZTcFh6VkhoY0VmMWJ4b0ZoT3FYZXlicmg0YSs3Z3JHZkdS?=
 =?utf-8?B?VWk3cm1DWjE3emZ5U2dyNHBuRGdvbmdRdE4wOGZJemJOWkVEUjZ3Q2ZEaFJO?=
 =?utf-8?B?UGsxZ210QmgxaHdjZ01yc2pJSVZEZHRPVE9zcElCdHRaaHkrL1lvQlpKMWM0?=
 =?utf-8?B?bHQyVFZ5MTArU2ZRa21BWXYwUGtCZ2VLVWRXVEVEOTJRUE5GY1FZc2xUSmhz?=
 =?utf-8?B?K2JvV3JPQVZvOFdlUzJuSDR0Q3kxWlJCUk9YOGtHYUtiL2I4bkpwcWVvczBx?=
 =?utf-8?B?UHl5Z2FycDZiVlVJRUZkVmZMN0dDUG1GOU1GTHVCeGdIMG1BaGw5R2x0M1Ns?=
 =?utf-8?B?bzZRR0NVNklLYy8wc2h1NWp0L3ZtcnJKc1pNWUxaV3U0RjI4cjJoTlhBTGF6?=
 =?utf-8?B?S3MwakF1UWtXR2R5dHFWRElWUWR2QXdNMmFYYjBNZEpLMTFubm1wbmQrOGs0?=
 =?utf-8?B?eXNVVzQ0VDhGOUJXMjAwdTFlZkhlb3NxN3hFaExuaUhKbkM5elpwcXJRTzBE?=
 =?utf-8?B?WjdKeCt0NmloclF6Yy81NjBRbnJub2Q2eUpaclVoc0RPTHpGelB1aTVvZkRh?=
 =?utf-8?B?MzU4WVd0SlNFeEdaQlFnUXl6a1Erb3RIVzVDeE9rL1NrVFVDOEd1MTlhRWNT?=
 =?utf-8?B?MUlzT1ZFcjFzR2VMdGZJVkVPQTdTQ3l1amhlVXJTd05ZbGdNODg1d3d1eTNi?=
 =?utf-8?B?djdNSkg2bWFOYkhteVZHd2J5eFlwVXN4d3RLR082TkVlT3NLait6ZnFYNlZT?=
 =?utf-8?B?NytrT1YwbmswdkdsY3pFbTNyeGJKNlhlS0lGb0EzRUNHemJNL2R6aFBlYTBy?=
 =?utf-8?B?citZNkdSUjRaU2srTy9KRkZLYUNTWWxMR0txWDU3a25RVzlyNnlaQXpsVGhB?=
 =?utf-8?B?cmpzN3QrTXkrNVo4WXAwK291ZUJvZmR1YVNkWEdPQzhhd3dYWGZVclcwTDgz?=
 =?utf-8?B?QkZnU2NUbGs5T1JaUURUK2RNVFlaeFNTZFkzSEdEVkZrQVFyRTJOSEwyaXhu?=
 =?utf-8?B?S2h2SEZWWUJjM2czRkJ0UVdCaGgyQUhWeThBK0pVZGFSczVFb055c0FFRElk?=
 =?utf-8?B?MnpzclFhQkw0WHcyTklnVE1WemJZOFRzSU81SG9pV3Fuc1NGbit5T203QVRE?=
 =?utf-8?B?MGxZWXN1TmE5a2hRM2ZUaytwaVYvTkFuUFRoajVyMHZNS0tMUXFGZUliQ1U5?=
 =?utf-8?B?THE1UzBNS1BYaHBvUjA0UXI1ZGFJeDVlUzhJWkFOUythZ3BURVFTQmk5UEhw?=
 =?utf-8?B?cEtycXNkVytBK3dSZlp3UG9WcmgyWnVGbGdsV2NjbUUzaEd5Um5XdVBLaU9M?=
 =?utf-8?Q?ZnUv+D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:33:23.0528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d3183a-5ac9-4dd2-1b34-08dddfdd5f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4048
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

This series introduces a kernel-managed singleton BO representing the
MMIO-remap (HDP flush) page and exposes it to userspace through a new
GEM domain.

Design ------
- A tiny (1-page) TTM bucket is introduced for AMDGPU_PL_MMIO_REMAP
  (mirroring doorbells).
- A singleton BO is created during amdgpu_ttm_init() and freed at
  fini().
- The BO is kernel-owned and never evicted.
- amdgpu_gem_create_ioctl() recognizes the new GEM domain bit
  (AMDGPU_GEM_DOMAIN_MMIO_REMAP) and returns a handle to the pre-created
singleton BO, enforcing size/alignment checks.
- Userspace thus gets a stable GEM handle and can mmap it to issue HDP
  flushes.

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).
* No runtime validation yet.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (7):
  drm/amdgpu/uapi: add AMDGPU_GEM_DOMAIN_MMIO_REMAP
  drm/amdgpu: Add New TTM Placement - AMDGPU_PL_MMIO_REMAP and wire up
    plumbing
  drm/amdgpu: Plumbing for MMIO_REMAP memtype and user-visible strings
  drm/amdgpu: Add mmio_remap fields to amdgpu_device
  drm/amdgpu: Implement TTM handling for MMIO_REMAP placement
  drm/amdgpu: Create Singleton MMIO_REMAP BO and Initialize its pool
  drm/amdgpu: Return Handle to MMIO_REMAP Singleton for GEM Create

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   7 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  56 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  13 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 112 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   3 +-
 include/drm/ttm/ttm_resource.h                |   2 +-
 include/uapi/drm/amdgpu_drm.h                 |   8 +-
 10 files changed, 198 insertions(+), 8 deletions(-)

-- 
2.34.1

