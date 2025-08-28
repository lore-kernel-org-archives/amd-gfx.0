Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713C8C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204A910E962;
	Thu, 28 Aug 2025 09:21:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W0XfOcH8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CACD810E95A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtOLhRZNdWDHqVx2BM/dBg7Hb1AikVDRccXFPNROkFXt/83juogMYRmsvEI3QppHwHPb3t5hbmgKc5NgfOB0dXBoWRgCYnk1OTgvB5iuDLdwsW9zs0h4ZSYAGToGTJtoPhxKSVK4IVHQsvc6zHmJn2OrDdwd5L3rTO9QlKxwaIESGWOsuB+3bF9dt1hiJ3I8c5vwPLcLggFfNLO0B+esiCI9O+hwU6ib++CxHcarEuiQK7nbHSSp+Luvd5PdTGXnpE7RmxGKMyYMTyvFOHXlWftNFINSpd76oX4McPwEKPfaxrpGgRBWghTwniJRrk3Mftl3tVbXiaZ7EGVZvUMrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGJQeg6pej7E1zxDH9v2WxOWJSm7f2cxxIHc86tPj+E=;
 b=Ry6T2QgKN4ooaFG4oBzwi04ch5u+oqnlvRXpJUIbLySS/cxzF9KzF1C5SzK4d4Dzt/3lf69NIOIDgtJkWHUCSSXRiOSpLWEhKYxTbtH7pjeiFeoR6UzVNUuN1TJjAK+aMFlVeroi8EDHoU+mUTa4ZJ4CCyVOBy/AET9f0cIHLW4dRb29g1l8kC+ezqIXstRy3iUEUQ/HZuZMu98ejW4Bn6+szmjvsi4qgRYj0V6IdlDBrSYGrOmK9EKa6nU+loSiWnYBcjzwF6ItiaorE9vxJe3yw1I4rFk1/Rxkuf6gPycRGa8ZBHNA15BvJa9WAVD6B9clTxV8IlxI0RZDZ3uc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGJQeg6pej7E1zxDH9v2WxOWJSm7f2cxxIHc86tPj+E=;
 b=W0XfOcH807zURooss7914Q657qXc7991JURmLIlltBvZyn4Rx4gykqpTEVKRx0uRVsWL/dj8PQEL/jMmjESHMq00u+kKu06yyFeMHoT7sG2C9phT2PZezhG4ekHIdocRnNNgKM1pcrHZ0T/5H4cju265YK6+9jys+k49JHlBLWE=
Received: from MN2PR08CA0008.namprd08.prod.outlook.com (2603:10b6:208:239::13)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 28 Aug
 2025 09:20:58 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::49) by MN2PR08CA0008.outlook.office365.com
 (2603:10b6:208:239::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Thu,
 28 Aug 2025 09:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:20:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:04:30 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:04:28 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/9] drm/amdgpu: Add MMIO-remap Singleton BO for HDP flush
 v3
Date: Thu, 28 Aug 2025 12:34:11 +0530
Message-ID: <20250828070420.3948568-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: ac28f183-d8e6-41db-fd14-08dde61432d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUVLVlBhSzlDYzVKYU83dnlYME1hSnI1ejNtOGVVZDJ6RWZNTmRMVFo3MjlD?=
 =?utf-8?B?ZVFVeEx2TzRHMEpwMkJRTklHRE5xdTBHUnJVaDFXRFRiQi9CUVNudDdqVU0z?=
 =?utf-8?B?MWpsZ2I3cGs5OWM2TXpwUG0wUXNqZE9JQk1UM3pZSUhtRk9IQlpYTWoydFN6?=
 =?utf-8?B?UnlSRG5OeGdYTEdnUWUwWUw0Mm8wYU5NaUVyaENEWGI5YXVocU82QUpkS05a?=
 =?utf-8?B?ME5td1YrRy9OZy84YjNaSUZkelM1M2dkOU1uV2d2aFl1TnFXTjZCVU15c2Z3?=
 =?utf-8?B?b0cvbTRxNTQzcE5CZFU5WlNkUkNUcWtUT0NFVGorMnBldVB6SmxSR0gxQWo4?=
 =?utf-8?B?V3pSRkM2YmtqZ0liQ1NObW1TSlU5U3NvMVh4ZGdPQTl2bTZSTm14b0VMRFJL?=
 =?utf-8?B?NlZESVp1akhNcVB1czhPdytXaDNvay9tUnhGSjBycWVZUFJ0TkJYcU9MYTlm?=
 =?utf-8?B?dGl4VHlGM1Q5c28vemRmUlVud2UvcVZuTEpPYUgxdzRDeVZ1Z1AxUjFpQjJM?=
 =?utf-8?B?elI1Vmp1cjhod3V1VzNBVWRIUGdOR1dzM3FCV0dYeFhPbnNVR2IxMEtzQ1lk?=
 =?utf-8?B?T1d4TFhDSlVkU0g2QU56WWc0aEtXRGQ1MlhOa2IxNDVKczYrUlVzOExteUNH?=
 =?utf-8?B?MDlFTjlzMGZValZxN2NnZWZTcGJmaE0xWEhaT2dRNmZNU0h0VTg5M2puUDMw?=
 =?utf-8?B?L3FLc3EzVWFURkVwQktkYUpBQzkyQmNXNU94TmwrU1N2KzIxSWk3Yys3N3Rm?=
 =?utf-8?B?Z1ZFTzlvMXMrbnYyZU1sdWkvdGlPZ3BjK055ekpIK3JXeGVIZjRqcXpwMDRK?=
 =?utf-8?B?RFh4QVNmNU14SVFRaWxFWjFmREJrSDhsVXhVb3hjdUx3NE41QkxvV2hhNlpx?=
 =?utf-8?B?MkxuRXJVbytMOG5iOXVvYmREY1Q1T20zbjJ0T1k1ZEdCTEJXR0NIUVRqeko3?=
 =?utf-8?B?U2ZheWgyWlY5U2NNSkI2OWZ4YytRU0ljdUs5VCtDZ0tqSS9FZnBGQUxLUCt3?=
 =?utf-8?B?WFFHRFpTZkhlS0t0RTdLU1F2SkJZRXdhMGVoS2lIekV0RlZmbWlsK3lGYU5P?=
 =?utf-8?B?L2syeTd6TGdoUGxsekFlaS9yZWdBMHhscHdhNXh0cy9iOEt3aGI1SVE0dU5N?=
 =?utf-8?B?QkhMV0M3RWZMMnBVZEpXdDZvaHc5L1FlY25OdHI3Y0xHN1I2SjVWOEhFNjNX?=
 =?utf-8?B?cVpaZWpWTmt0dStpT1JwTWpTQU1FZjkvRXlpL0JPcFBJWVBidVp0NHQrMCtN?=
 =?utf-8?B?WVZNMVZMU2xiRDJWalhZemFvTmFaVHh2U3pRYXEwUmc1TTNvL2FmTUhLNG9S?=
 =?utf-8?B?N2VqQXhmRWlOVVRGMkJOZGZ2RWt1MjAxSGtlMzI5QXliM09iVnJJSXEyVVFa?=
 =?utf-8?B?SEZmdFpLRWZpOEU4aTZZZm16anlLNGpLUkN1UkJrVEY5Z2tPUnJaeFhtL0k1?=
 =?utf-8?B?TWwxT1Fvd05Tekg0eGNkbiswR0RrTGJUWTFQTmdEWU5OQWFwaFNybkZlVU5j?=
 =?utf-8?B?RmFhcDN0TVlFb2tzeFlKWUNKWlpCMlF0WnE0MkRUUGxRZjJTUGtLcFZDaWt0?=
 =?utf-8?B?K1Avajh1L2w2Qk50Q01RL2NPWVhHdUZjTXJrT2tGc0tjbmsrSDZzSW9CQkQr?=
 =?utf-8?B?VmN3NERXRHZScEQ0cUVSY0NKRW0zb0g4WXh2aUxRTWIrWU50bmJOQ1ovVTVV?=
 =?utf-8?B?aFNyK21XNzI4bW1kTTVtaFJuL3JhWEpra05hUHZCeW9TYndUYlRhN2dDYUZt?=
 =?utf-8?B?aWZwazFtMHdLallDVXNaaFRTdk4xdDRkeTZDOXViSTZhYmlQWEFtV2NXUEVp?=
 =?utf-8?B?RHN6ZjVtK2F0RC9ZMFdxWG82WkxjT0FLZFlqV2VjM1l0ajNZdHdNSGVGTHlw?=
 =?utf-8?B?ckcwUkpxUzA3VHV1Z092NFp5Z2RIRWxzR0M1ZVZQR3Z3VUYyYVBnVGk3Wmk3?=
 =?utf-8?B?T1FnbDhZLy81Mmx5Qm5sM3N1SjFpQmJoL25KaitreTAxeXREbG5NbVFjc2kv?=
 =?utf-8?B?UE94eXJyZC9BPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:20:58.2654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac28f183-d8e6-41db-fd14-08dde61432d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
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

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (9):
  drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
  drm/ttm: Bump TTM_NUM_MEM_TYPES to 9 (Prep for AMDGPU_PL_MMIO_REMAP)
  drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
  drm/amdgpu: Wire up MMIO_REMAP placement and User-visible strings
  drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device
  drm/amdgpu: Implement TTM handling for MMIO_REMAP placement
  drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
  drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton BO
  drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton in GEM_CREATE

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 62 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 87 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +-
 include/drm/ttm/ttm_resource.h                |  2 +-
 include/uapi/drm/amdgpu_drm.h                 |  8 +-
 10 files changed, 174 insertions(+), 7 deletions(-)


base-commit: 6b70b6008d812a9a210455dd55459a21279bad1e
-- 
2.34.1

