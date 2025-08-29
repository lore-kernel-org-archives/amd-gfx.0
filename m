Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5F5CA0FF9
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 13:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C32210EBC3;
	Fri, 29 Aug 2025 13:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WdjViaIQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66C1810EBC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 13:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLvJGJo29XOfgPtv+kb6nPxqN3QAYeIBf8gy9qhKkYzmDxHI0qdt0tgbHmqDyHeftXxazFodBmcaDnlva7FWefcpx8PosCu/PUaD/JIONoO3NtP2TVl1Mjn5vwyRxCa7F0RkwmMh1OKg3O9GOzdHztmPxCLpaS6xiToKxasBWFvtdXsOq46+MNY8NQD9H0Vi+nhg5Y7XIEFeN2wC2mrcypZRrZBZC//yNST0Zt2iAb+xdrFOMVt0ff4B63e4m3w97yGXLQyar/rTsDdhbJn4MJMOSEc669jf3oV0lJ+yLlc0wuxaVKCV/Y4rIIInuh6/bDBWc5lBO0Ovef1u77V5pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhMyR+einHpfuy45bQqZwR+2xMpiClZG0c4qhwzgGio=;
 b=nOuueXYA8ulcTXaWe1v31+UbAAOdZE5Iva4i7Lyd/xDtbhe+/b8pB+TaDeigNIWW+OjinWneDpvzcbkG71NHK+dVOjKahDlznBFgpOF0aUdQwWfvHE2sHbjg5gU6dyDBWZ+x+2bV74ZyP5MWOBJhhah6F6NFk1JE/2cJK2UVDRv3F596iK8pyCXr2kr3wFZGwOLdaIe4JHQefNyBYLaHdJUggHERsPXr7GE4y+JINczzdguqUdbXl7hCQQ6i+L2EAPzDRCD+f9urVN+uS9RRKB+bkXsI3u+76gJIgEICUIGw1eJGDUoMrfp6f019oSlbNkxdse69B1EEvB6WVKAGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhMyR+einHpfuy45bQqZwR+2xMpiClZG0c4qhwzgGio=;
 b=WdjViaIQjm+Grit9xYrm0vbNW7Uq85P0DUBAovQPO3vuyULUaogRBG6/Y87+7jVUgjE05OKnULdyAIrzyqEJCyxajsT05RZvGNv0hLePIY9JXSnwnrBbnOXWy6lDlKXQ5GEbssap4X7SNCHcCLN77PAYymo3D/iFj7fKkVmKSAc=
Received: from SJ0PR13CA0102.namprd13.prod.outlook.com (2603:10b6:a03:2c5::17)
 by MW6PR12MB8735.namprd12.prod.outlook.com (2603:10b6:303:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 13:55:43 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::14) by SJ0PR13CA0102.outlook.office365.com
 (2603:10b6:a03:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Fri,
 29 Aug 2025 13:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 13:55:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 08:55:38 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 29 Aug 2025 06:55:36 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v5 0/9] drm/amdgpu: Add MMIO-remap Singleton BO for HDP flush
 v5
Date: Fri, 29 Aug 2025 19:25:14 +0530
Message-ID: <20250829135523.4032168-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|MW6PR12MB8735:EE_
X-MS-Office365-Filtering-Correlation-Id: a7b5a3b0-c6f9-4c71-4886-08dde703bee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eHpsY0EzSmRjaVl4RVprUk51V1dKa2VCbmRESXBvWHVldmE0bVVBZFNrUlpw?=
 =?utf-8?B?dEY1TzBRYlRicEhDNmE0Y2VRN3Z5RHZaNVRQVnpBbDJHQVQ5bys0ZVNvYVU0?=
 =?utf-8?B?akEzMThPUzZqUDdiKzMwMHh5UkE1TTlocC9tNEpJRkQwVURDU0ZFSjQ1Mmtn?=
 =?utf-8?B?cTV1cU03MDM5clNQT0tTeWtDQXc3OTJuMHF5cUlqZEtsbENzSnBqa1ZXcklq?=
 =?utf-8?B?dVNraEwrTFprM2EzTmthZjN3akVqMHZ5by9kN1pWckQyV0ttVlV0N2RZNThG?=
 =?utf-8?B?Z1lpMklJNjlFYmkwemcyd2s5SnRXTlZPUUpEUW5Mb0Zoa1lUNlQ0TjVPVFRK?=
 =?utf-8?B?alFjdUlXSkJDUElCajlNRVFRTnd4Y1hLcjJDTDFqSVVrbmMyZ2F1enFxWHEv?=
 =?utf-8?B?c3pNcnB4TTRvbzNkaGg2bjNwR3JjMllXNzkzQllRU014OWpDVnhsS3VHWTd2?=
 =?utf-8?B?bHNqZ1VRcjM0R1dHTEN6Q0JFdHNERy9XbjZDanRRU2oyV0VTRWd0L2ZOOFY5?=
 =?utf-8?B?ZnRlRWN5dXlFY3RhMFhOOCs4Ykt6SHN4aFVmRDY1aHhkbm9oaGVtTC9ka3pm?=
 =?utf-8?B?SXZpNCtzVXdBbFRIcEhZL3UwSWJCMzMzTjNXWi80QTBFZlRjSTAzWnZpSDZk?=
 =?utf-8?B?TVF6UHVXV2pjbWZlUE5jMG1sd0tESjAwc0RRT2xwK2FUZHpaZlNqQWY5cGxx?=
 =?utf-8?B?QTlMNVgxby9JOENUV0ZwY1R5V3Bwb1k1dlpjWlpaSURPekljTWdEcDNmTmxq?=
 =?utf-8?B?dnlhTGtXakpxNVY4VHY1dEp4blZpcGxkblhYYWZ2SU14ZHVHb2oybU03QlZ3?=
 =?utf-8?B?eDh3RU9jS1U3b0dqdXhWNEpqUVMxZlpTUHZGcWtPd2k4RG52R3VzWU9Ub1VL?=
 =?utf-8?B?VGVpYXNTMGVuMlg0TXViYnROZHlqUGU3Y2N0WTRlRThmYXZ5RFJtS0Rzcmp0?=
 =?utf-8?B?ZHJ0U1lTS2xOelhCaVdOQ0lpTjF3NEtQdHpESWtURTJ5SHNIcVNnbzhuNWp3?=
 =?utf-8?B?aGN2RXo3QkRudHNQeWhzalN3ZVcrZDk3akZVVWE3eUxBUlRDaVprQWkzSm5o?=
 =?utf-8?B?Z0RWWDhtWFc0N25teGhKNnhXdUtBeVFkblVFRWpIc2V0Y0ZiMkE4NzNmWkdw?=
 =?utf-8?B?UEhHcmc5ZUprK2FKMURUbnlMd0taRE9qN3owb2wrZ1B3VlB3UEkxYmR6ZnM5?=
 =?utf-8?B?T0RvdFhsYjNSeVFnTndZRjVqdGkvOGg4ekFQS1BGaVpPSk5hUGFTZDY4L3N1?=
 =?utf-8?B?QXh2YlhSQjN4Q05ZUzlzQ092STZDQmoxZW1YS2VSTjlaendDZmVIV2RrclV6?=
 =?utf-8?B?V3NQN2tJaEdLcjFLc3lab0RRdFNlUGZ4Sy9Xc2ROMzJjMFVEaDUwallnd2Yy?=
 =?utf-8?B?QVF3ck1kWDl3amo5UjZYTUhsa2QvZU9KdEVLTGQ5R1EwdkFTM3lXQXpwUEJH?=
 =?utf-8?B?SW9DNnVyK0VpMFpHbHNLMWdtOGxnQ3cxYzNXd3pVTDV2OHpvL0VuNU4yYk4y?=
 =?utf-8?B?ZmlTNlB3RStNRGptSEtObnl3QnduTFhJVk8reUZHQlRFT3FIQUcvV3F3TURp?=
 =?utf-8?B?a0pmem5jNE1VZXIyMVJLeHdyRkVMNjdBdVRhanE5b0NxbjJSbkxZYXVoZVV6?=
 =?utf-8?B?M2Vsa1VjQUYyd2s1cU1qc3l5bHEraTNHWUxaOHl0VEZyR2FmMUFCc25DRmY5?=
 =?utf-8?B?VkRrWjd1d3lRRUYyVXpJTmR3QnRzQW16TEZRRy85eklsSXh2dFdHVEIzNnBz?=
 =?utf-8?B?OWZydHNiL0k2V1FMclkxQmo0WXRzNHdhS2tPempiYkhPK2hTWEprRTVpM2hR?=
 =?utf-8?B?TThTa2d5ckIwQXpwVERRcDlnamc4cDQ1alNobDR6V0JDRFdRc0VqOEFrTkhl?=
 =?utf-8?B?dmpNOHkzLzltTXZ6aWNRc3o1SDJVQzdld3crMEwwbzBTTVl3ZkcyeXlBajZU?=
 =?utf-8?B?dStaVnhGL0ErY0xVWUxPZHZ6MWU2bGJtK1N1ZEpjOVF0TllMK1NXeGpRY2NC?=
 =?utf-8?B?MURJVGV1VHBnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 13:55:42.8742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b5a3b0-c6f9-4c71-4886-08dde703bee5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8735
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

This series introduces a kernel-managed singleton BO representing the MMIO-remap (HDP flush) page and exposes it to userspace through a new GEM domain.

Design
------
- A tiny (1-page) TTM bucket is introduced for AMDGPU_PL_MMIO_REMAP
  (mirroring doorbells).
- A singleton BO is created during amdgpu_ttm_init() and freed at
  fini().
- The BO is kernel-owned and never evicted.
- amdgpu_gem_create_ioctl() recognizes the new GEM domain bit
  (AMDGPU_GEM_DOMAIN_MMIO_REMAP) and returns a handle to the pre-created singleton BO, enforcing size/alignment checks.
- Userspace thus gets a stable GEM handle and can mmap it to issue HDP
  flushes.

v2: Updated review comments from v1. (Alex/Christian)

v3: Updated review comments from v2. (Alex/Christian)
[RFC,v2,1/8] drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP | https://patchwork.freedesktop.org/patch/670410/
[RFC,v2,2/8] drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement | https://patchwork.freedesktop.org/patch/670411/
[RFC,v2,3/8] drm/amdgpu: Wire up MMIO_REMAP placement and User-visible strings | https://patchwork.freedesktop.org/patch/670412/
[RFC,v2,4/8] drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device | https://patchwork.freedesktop.org/patch/670415/
[RFC,v2,5/8] drm/amdgpu: Implement TTM handling for MMIO_REMAP placement | https://patchwork.freedesktop.org/patch/670413/
[RFC,v2,6/8] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap | https://patchwork.freedesktop.org/patch/670414/
[RFC,v2,7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton BO | https://patchwork.freedesktop.org/patch/670417/
[RFC,v2,8/8] drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton in GEM_CREATE | https://patchwork.freedesktop.org/patch/670416/ 

v4: Updated review comments from v3. (Alex/Christian)
https://patchwork.freedesktop.org/series/153610/

v5: In patch: drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton in GEM_CREATE | https://patchwork.freedesktop.org/patch/671576/
- Drop early -EINVAL for AMDGPU_GEM_DOMAIN_MMIO_REMAP; let the
  MMIO_REMAP fast-path handle it and return the singleton handle.

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (9):
  drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for AMDGPU_PL_MMIO_REMAP)
  drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
  drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
  drm/amdgpu: Wire up MMIO_REMAP placement and User-visible strings
  drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device
  drm/amdgpu: Implement TTM handling for MMIO_REMAP placement
  drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
  drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
  drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton in GEM_CREATE

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 60 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 84 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +-
 include/drm/ttm/ttm_resource.h                |  2 +-
 include/uapi/drm/amdgpu_drm.h                 |  8 +-
 10 files changed, 169 insertions(+), 7 deletions(-)


base-commit: 6b70b6008d812a9a210455dd55459a21279bad1e
-- 
2.34.1

