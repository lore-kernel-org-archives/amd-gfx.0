Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A292CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB85710E1C6;
	Thu, 28 Aug 2025 09:21:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4skHmVvm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E57A810E1C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TsKRy/eC3wiKJxzGflwpbvIRAaEJfJQu2mlSXPgb6xb9dZVW8G7IdHfn4hi2WN4Vbd7cRN5Di//N2u6DBUiqXWkpHRkcig68jVNx6gjynzX0FI26BQScu4lYUdB3gcUsRn9bqxyYheQ1yan09hZo2OvwBulhUOSLcNdyFn0ZHSvpMOc/zYQOO/eGTX3agUHyH4JU99Ee8nzhx6b/49qlbVuVeeggOwMJXBndGGR2Rr0Jpg2/BFqxiQ42iwh1M/3l/RTUGcpfHF2WWCyjra9pPL1Y0jJXaT17RuUaJPaCz/B5gVDSid58nLLh3ZgSf8nB552o8d9LfdwkzY4URHPzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGJQeg6pej7E1zxDH9v2WxOWJSm7f2cxxIHc86tPj+E=;
 b=QWuvxnS7TMtzQn431Wa8r+k/Xl8QEX6Kur2N+VrHeaDiWEC0Au57JCP5fBnHJdD7fqo+mTecW3C1vdWuxZlSThOyHO6jgcBshlM2OWCE4P0smyGDPBxTj5PDoCFXiznpcE9O0GOc6I9MT5oajtkLUjfjcvOMVNduL0vtlOF53OPKdDcxTX0Ff9il8h4mRV58nCgoLt9a5rr3dUz+1UedrRiV1uXNtJJGDDkZ0xpMKos8uIr4MjmdoAzgcRDFYJpjHLK1R4LvLmG6HzwKY60eIyPg3UnQone8BcqnQhAAGUfHulp7qXnFdF2Oj4588DItb+gb79AOQ2hht8BwYfVDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGJQeg6pej7E1zxDH9v2WxOWJSm7f2cxxIHc86tPj+E=;
 b=4skHmVvmoH6Ch6AEIoMyjeqFQNwBzn5GrXX47EIypnfKvcAarJP2SB3f1y346uPiTXq7q8o63grvU3ZPh2nnwbEt8T7tUGv1bcYOu5fuKKEO7Bj/FqgINQo0zVXOjhPlDDRD8MKfkOg8kKLW438N3VyNlyRWqv5h2C79GyZUiKI=
Received: from MN2PR08CA0007.namprd08.prod.outlook.com (2603:10b6:208:239::12)
 by CY3PR12MB9608.namprd12.prod.outlook.com (2603:10b6:930:102::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 09:21:12 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::50) by MN2PR08CA0007.outlook.office365.com
 (2603:10b6:208:239::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:21:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:11:42 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:11:40 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/9] drm/amdgpu: Add MMIO-remap Singleton BO for HDP flush
 v3
Date: Thu, 28 Aug 2025 12:41:22 +0530
Message-ID: <20250828071131.3948765-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CY3PR12MB9608:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ba71fc-7c12-4463-783f-08dde6143aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXQ2a1krdFRTZ2FVUUJpcG5Ha1BiZGZIV0paR1Z3QmFwME5NNHV0Um1lTGps?=
 =?utf-8?B?ZlozRWNzeUlZYVhQVVJDci9mM2dxZ054ZWdCMmNzY0Nra0JnVmFQZWRFOUw0?=
 =?utf-8?B?Mnp3RU16S2dsZTBaODRnQitMNEV0R1pVVVRML2JzQ0V2VjFSdG41NzNhcllz?=
 =?utf-8?B?RjJNT1dTSll6WjJqTDhsOWw5M3NKeU5BM2hHbGlKdWk0dTk3T3NKVko0OXNo?=
 =?utf-8?B?M2R5TC84ZTVwQkVhRm5mWTZ5cnQvemRLSHZqMzdvZFBkSnRJeDE5Q3BuaDRi?=
 =?utf-8?B?QVFkaGZvY0tFTVpXcG90VU95S3ZoVHdxbXgvbnJSRzlKSHNqUGtDbEU1VWJs?=
 =?utf-8?B?K1ZCRkVLQmNteFB2ejRFbVM1SlB5QjkvOFdidStGTVQrTDZ6alFZYnJzYnFP?=
 =?utf-8?B?TmlIWjVGdzBtaXJLbUVpWVRHL0J0Y2c3LzBYV3NQQlVEd0VlalNmZzNXajQ3?=
 =?utf-8?B?dXk5dk9oUmZQalJHSUtsWnNxK09pVlBNUFJ6ZktZS1ZwYVJSWHZyQ0FDdUNq?=
 =?utf-8?B?TkxUY3JJRTMwQTVvL05nbTFrUlppTk5JanB0WUtnNE0vZlYvRTE5Q2UrbnUx?=
 =?utf-8?B?K1pNM1I2c2ROY0dDczIrbHZDc1NCS2ZZODFXRGxmRkxMeUt5K0dnSExIbUp0?=
 =?utf-8?B?MW5SK05HUHVoaWt4YTRnM2pCREJDYitPc1JqWlIrWDc4enR5Z1M1a0dGamdn?=
 =?utf-8?B?MU43aE50dW5JdzZkd1FQemwrL01DM2xJQ2VOWWNSNk5ZU0hudGkzeFNmNGdi?=
 =?utf-8?B?cDcwNXlDbE5TeGU4RkdVYmN3N3hYZ2liUVNuM3VhZU9ZdnU0bnhEM0tuL0J6?=
 =?utf-8?B?OGNoSFBJa0hNQ0RXc2laa0VaUEpFSll3Q2NITlVsRmN2VEdsNTI0NjViY2ph?=
 =?utf-8?B?cGJZRUNyRU5KbFd5MFVyZ1FhV044K01EL3QzZ1dVd3p1TmNLNHY2Q01aQ1hO?=
 =?utf-8?B?bUV6c29OU1dtRnBiN3RhRThjcFU3Zm8veHBrVlhwMEhydHYzUTNqazgvd3Ft?=
 =?utf-8?B?MndwalBBdmlMYWNhUU5TSS93K2NadTJIVjdyZ0tpdkxUU3pvL1MrdjNEa3hW?=
 =?utf-8?B?VllFT0F4MWNVbFNjQmVUWXNSWXVMZ09oNGJJOXVQbDlmWGo1UEJMaHAwa2tD?=
 =?utf-8?B?amNTSlpzVHBwZkRvbHBtQ0pqQ1pRMFRwMEp1dFZZMHgvV09kaWFuYU8wZy9t?=
 =?utf-8?B?NkMwS2ZaQ2FNZGxxODZLMExZcXljNnY4N3NQL3RsRmJGeW1UZ29pb3kxNVdU?=
 =?utf-8?B?SDJJN1Q1M0xkamphaDVycEtEb2NYSmd3NUVSdjZPSHZlQkVVOW4ydk8vY1NS?=
 =?utf-8?B?MU9FNmRDRnN5K1pkdnlkREU1ZVczeU1XazdTVEYyeFloMXNYMFdSeTZQRmZV?=
 =?utf-8?B?cEhrZUl1MTZaQ1ZDMzd6OUwrTFpTSTJpdFJFVGRaOXlaQTROL28vWmxjN1l0?=
 =?utf-8?B?a3l0QkZCUERyTE1rOFdkb0g4aU9oUUZHTjVEUXdUNU82ZHJKNXdiWit0dmNX?=
 =?utf-8?B?N1YxeCtINDRPVDNlMU5IdU0zVW52TzRJb2NPcFVXVWZ0NWZudWVsRWVSR3pp?=
 =?utf-8?B?QlZBOUU2Z2lZSXFkVXIvRkE1clF4UDVRYU5NNFdDWmppbzFqSFc4S1dDcnk2?=
 =?utf-8?B?SkJtQWVFMllQL3E5YjNQbWVMWHVTbUNDM1hjZ01LZFlleHFXUDdmNzAzS3Vy?=
 =?utf-8?B?b0hkN2VSWjFvblNtUVBRWU8xanJZM3p2RjZiTmlXVktTYmZxM2Zackwra1Zp?=
 =?utf-8?B?L0laK2hUMUtlSVRta0N3MG5VbFpRQzRUejJyaEU5S3h3Q1gvNU1nY0g2eGtw?=
 =?utf-8?B?ajJLSjEzNmlPMjF1cXlOWG9aQW11ME81NTh4Zk5UZHcyaVZzaWpCNkxnaWpS?=
 =?utf-8?B?ek80bGFHWDRTS05KNC82QzBnMnFWWDZhYXpyUmtpOG5EUm5aMUhwSlA5bEFN?=
 =?utf-8?B?MlVIMXV0dzg0R1kvaWdhdUFlUndpNGM2QmhxMSs3NDhpOTJQbithS2JrQWxs?=
 =?utf-8?B?NVpubnZhZVV3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:21:11.8547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ba71fc-7c12-4463-783f-08dde6143aef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9608
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

