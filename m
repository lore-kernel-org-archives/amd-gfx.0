Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE65CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:30:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A36710E088;
	Tue,  2 Sep 2025 03:30:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CwjAWyE0";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 729D410E088
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYT7v7HX90+v2vy+BsoptOOVLSAI5H9vHrx+tSxvfCT26IiwGgJbi2Og55dz955MbQdlLTRWum0qr7WssiRWLy5SSQEMjptvraF0JJxqPCoGmbcfmKSScbmKGKC1tdQKi1XWEV0gtse96uPO7764DSt5SM10hycDtYBWcGYeuVdOhQmw+/kR1ZXWbVbaol4WINg0SAoMJ2T0G174at2B8d6V/oV9nd2ezN1SpDSf9VblZ04XENqgRantmxsT2/SMrOK23Iil3e9XUAhM26e2TH21IZFiGqJnSzBNcHlS55rooqQLmGrFWLfs4BP8vr5P8W46kwnBB6a/gaN1cAmtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rE+RYwp3JHSzfolhO8sNf3SuwUBXCMxbDoE4uyzli+s=;
 b=FaThSAJ2X+iDdJeJvqs+WmN/yfAnA8ASczDFAtTkY2QGXIAJf1vaUpBzqgJx6GsM2GKZ0e1QjGtnpEHPpW9dwUBmyv3IfzTPClkmhwFAk4tI23WJbgLfc1CjrTfxZ8610Yg03l3hxGOnRhaiUqDAyR+HqluI+LGcwYxpw0W0u7G59rXBbpBsZLl3iGlXSTtuVWOuUKmIRYVD+a5DS5la+b74aTL/KFo7PjFWYH7AP/FEHKKjzTC7jkkTg1ZvvgGVloT7kz7rBfCjotJZkhEn8Mi5hGxl85SpN5GZqQC6MRcMYow3AeKHpEiwUr7brUI966amIBQuR9XLqsfUGeLD9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rE+RYwp3JHSzfolhO8sNf3SuwUBXCMxbDoE4uyzli+s=;
 b=CwjAWyE0Gu4Wzra1WMgvL82GGkqsi1ml1UTfYypA/5VXqwB6voB2SSduHc85aWBTXsZBj0FUmc31OZ1IBTe9ZGkvtet6lSiJIVFE+KvAk2OhFxOlcNF7TfWpgoKPvDWKCb/G4r0MAgbjedorHj2zRyU7wPS83eieW0koGoN0618=
Received: from DM6PR03CA0018.namprd03.prod.outlook.com (2603:10b6:5:40::31) by
 DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 03:29:54 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:5:40:cafe::84) by DM6PR03CA0018.outlook.office365.com
 (2603:10b6:5:40::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 03:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:29:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:29:53 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:29:52 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 0/8] drm/amdgpu: Add MMIO-remap singleton BO for HDP flush
 v6
Date: Tue, 2 Sep 2025 08:59:30 +0530
Message-ID: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: dca4e6d3-be67-4c84-6b20-08dde9d0fbc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3JpOFRGSXE1ZCt0YXROdXFYQW5rWGhlZDFWV3F0MUJOblZwWWFQUU1Hd2Rh?=
 =?utf-8?B?VEpnYWhJdTA2RFRuai9PZHl5VzdSekd4RTBnUmNIdkp4Smx1RnZKT3FidVd0?=
 =?utf-8?B?RXNPTGEwbGlCTENsMTBHRHpUR2xYZHdnVzJnNnUxaUFKV0Q0TTlsLys0bXUr?=
 =?utf-8?B?ZWozbHNYQVJCQXBXeStkblpvdXFTc1JRVENUaFZiZUx3UHk3bUpGT09SQkND?=
 =?utf-8?B?SHo1cWJzK1RVRVBQRUNob2Flall5UGdKN3p0RWFRYmg0dFVrTkxDK1NVZU5V?=
 =?utf-8?B?NDZ3SVB4QmhWc0lBYjBwU1RRQVlXWHlQOVljOUt2Mm91aitXbDRVeUlkUWFB?=
 =?utf-8?B?MHl6dFBlUzhwMGZGUDNKS3hKdm9YL2cya29haXkrd2xjTHVvZnRjYUJDMG5o?=
 =?utf-8?B?SUZLVnB2V3lPc2owTDNzWHRHbXJnL0RaMXE3L2I3QzVTOE8wTkNJTHFlRVFP?=
 =?utf-8?B?ZWxBeXhobXZjcSs0VkdQUmRGSVdIWUlSNkRpeHBBV2pDOUh2ZGdQVHNxbjlI?=
 =?utf-8?B?SFFLbDl0ZG0xdjI4U3FyTEsySlh2Mlo2c1lOYnNsSURmdzVqcFdpc2xXb0kw?=
 =?utf-8?B?eVBuS24vdEM0QVJzUENaOU9PanRWa2hWOHhQejZDNGgrMWRnK3pKTldHQWNu?=
 =?utf-8?B?ZWc3K21JajhOb01PME5YRDBCT1poNk9RWEF1cjI5ZFJCSkE1TU5MK3BoSTg3?=
 =?utf-8?B?VlZxN1NhNnJPU2VMZkYzZG1Bam1MMllvcDNOVVZjY3EzWk9rTjNibEhrYUFY?=
 =?utf-8?B?QVBzeDUreWsyMUhJYW9zSlRkS0M4SUZ2NENHQmlZTk1hdmF2eERMQ3hMR2RT?=
 =?utf-8?B?SUlRSjNBdGNML2tnNEZQM0M2cStCL0hmRnRqV1h2RVhzdWYrcW1EdFptSE9Y?=
 =?utf-8?B?eGxOUzBKWlRCUFpJWk96WU50aDhnQ0FaMG5QaCttY1dERExKb1R6ZkZjVlVI?=
 =?utf-8?B?SjRNT3k2TWFHeWZiNVY1Zm42ZTZoYmFiUzd1cFBrOEMrRERmNXVPU2MzVjFm?=
 =?utf-8?B?NW14TVJCSlp5dDdHTDVJbVFWNnN6empmVlNhQzRzbzg3SVR4SUVyNk1ydnFG?=
 =?utf-8?B?aGlpazloRDVxcU1BOTRzeVc5ejQxaEZZYnJtanFpUTk4ejE3elVnMHJrNjV1?=
 =?utf-8?B?ZjIrRWtPZDlTYVhTVW1rQUlEcEIzdXY0Q3ZqWWU4TlEwYlpRb3F3VkJBbGFk?=
 =?utf-8?B?dEx6WVNwMk4rRmxCVDZDbVBuNG1PaUw1V0hwU29ZaEFtZzRibkZ1eGJpNlZm?=
 =?utf-8?B?N1QwY3BORGhnVEpOekVSM3pHWWk5Tnd1VzV3OWYveDRteGIvWXBReDJWUXBX?=
 =?utf-8?B?ZmNRYnFiYzA1ZjJubUdKQmt3d0pkeFFSUGRXSHJzOTZHaDlpdmNKMERWN0tr?=
 =?utf-8?B?NVloVFYrOW5FTURzSjI4a3ZWL3lqY1p2M3FYUnU3S05hQXVSNGJ5Sk1kYkhm?=
 =?utf-8?B?dTJ3MlpwdUhjZ0tFUWx6U0hWNzFTcGJnZ3N4Wk94S2Q5bkUrNEF0YUo1L2lD?=
 =?utf-8?B?QnNnYU5HbnNyTzNPZU5sQ0RsWURCN2w4cUpmYWpiUnlKN0FwYUNUK3VqVkJo?=
 =?utf-8?B?TU5vZ01WSHZGdEplTkpFVyszMVk0UE5OM0xuSGYvVjVIWGEyYnViTmZzampx?=
 =?utf-8?B?ekFoMSsxRjgzK3BLcVlvcjE2ZjJIVURUTlB3dEYzOXJCR21aQjcxRUJKSDJJ?=
 =?utf-8?B?eXY3WFZoQWRsQ3AyVzVYNFlyYXJUU0d3QlhiQ3pVR3ZMc1BxZUFPVFZkL1BY?=
 =?utf-8?B?ZXZQOC9EVzdSUk9ZR2JRekVybFBaUmt1NlVvKy9IV1NvbVhkTUpreTdTeEE2?=
 =?utf-8?B?dWExK3FLSW1wYzU3OWpUSzF6aVF1QzFDcDhGSkk2VFNMdWplb1N4NG9NNEZG?=
 =?utf-8?B?SmEyTm5DSDcrUm9tVE9kc0daS3grWThNOGVUNEEwYjZlMUI3a3M5amJnWmJk?=
 =?utf-8?B?eTEvNGt3Rm1hR25lQlVFWHJtZndTQkNjdXducWp3WnFVSDNwUUhhSC9SYjhY?=
 =?utf-8?B?WWNpS012Ukd3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:29:54.2028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dca4e6d3-be67-4c84-6b20-08dde9d0fbc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
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
  
v6: Updated review comments from v5. (Christian)
https://patchwork.freedesktop.org/series/153209/#rev3

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (8):
  drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for AMDGPU_PL_MMIO_REMAP)
  drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
  drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
  drm/amdgpu: Wire up MMIO_REMAP placement and User-visible strings
  drm/amdgpu: Implement TTM handling for MMIO_REMAP placement
  drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
  drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
  drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton in GEM_CREATE

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  55 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  13 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 115 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |   3 +-
 include/drm/ttm/ttm_resource.h                |   2 +-
 include/uapi/drm/amdgpu_drm.h                 |   8 +-
 10 files changed, 195 insertions(+), 7 deletions(-)


base-commit: 6b70b6008d812a9a210455dd55459a21279bad1e
-- 
2.34.1

