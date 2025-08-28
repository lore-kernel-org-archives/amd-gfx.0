Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53D3CA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49FE210E941;
	Thu, 28 Aug 2025 09:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JO4ZDm/3";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBBD810E941
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:21:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uajCIEMeefI6aN0asfuVQewtD/hhRgzI6dRE9ferBda+zBB10xS4yzDm8iuKs0mCWJcoc87AHuGDZocLGLj9fXpP9AkisITnqKKYLmHPU9yZshLQlyi9wdYIpRJYs33G8ByMRcxPzcU/CRSWp5azfpTuPvBdXiOlIpIxtdYXdiCDMrSY2NlwSePUX54gEXJCXCGeSBe5yQyS4jCRV0m/mCSk05WnUYC40zXGvKySNrea4BbDn9r3S2pZFgKpHacBNlrRpRh7kiHdErw+J102V+jhiiWFq+VV9Ok8fA9zhDsi+eH2gosy20eDtNZ5maLOTsmldAcFEQI//Yv2VQiHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGJQeg6pej7E1zxDH9v2WxOWJSm7f2cxxIHc86tPj+E=;
 b=Rui0L8zBe/L/BAVRMRVBnOCu5iw905TAeACOk2Tpk+cnBdwOt9lJ0k6MTGcBVrYzAo+iv2qasQJwHySBi/xtxTGGF7BWxnW9ZAr90H/1hedW8RlBf6TfK4kuRGLQhvcboKXBAOc1M4wrbHHEWkV20nPIOSTCWXRdnklgLS0/7o7zpuKSLqatgvCX749/UDRb1QIjrGIc6zswkP0IODgArVoKU8kxk5w5y4j5N1XPxnSLSvDMQD0SO8v2eO84D4tphnxSjrazMuIAu+WVf7pbFw4zVIb0ABQxm/xC6P72Cbmo17EmX3tkatXooYtLB+fm++r3ZR7q6+o7ZNoHfGaU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGJQeg6pej7E1zxDH9v2WxOWJSm7f2cxxIHc86tPj+E=;
 b=JO4ZDm/32LHyIsHNIwaVTFt8Wr1yeOPA0pupSbTH1H+WIVu1fzl5Xlh/B9bYXcsNWaTyD/3+mHlaDpcVvkbG9O57Sok5NM+VGaGZcffneW18IW8ApjxP9kNddEiharX9XXAHrVLdEZscxsEKdMi6YpxNEK2A/GMb69gVtd7dSoY=
Received: from BN9PR03CA0739.namprd03.prod.outlook.com (2603:10b6:408:110::24)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 28 Aug
 2025 09:21:14 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::5f) by BN9PR03CA0739.outlook.office365.com
 (2603:10b6:408:110::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Thu,
 28 Aug 2025 09:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:21:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 02:13:51 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 00:13:49 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/9] drm/amdgpu: Add MMIO-remap Singleton BO for HDP flush
 v3
Date: Thu, 28 Aug 2025 12:43:26 +0530
Message-ID: <20250828071335.3948819-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: caa7628f-910d-4326-f7d6-08dde6143c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YitEaDdpaHYvMklEZkFvVXYxR3RwOE9vbnRCOS83b3ZxS3N1blhUQXlqQkwr?=
 =?utf-8?B?b0hxQ290UXp6Q0lCS3dIdnF5bUVNd1g3K2FIUU5Mc2UxbzZkZjRqL2RqLzJH?=
 =?utf-8?B?NzdENDRMWFlaSEpSdTlERmZVbG9ic3lhZ25iN0NFWGJDZ1g3UTdETVdId21N?=
 =?utf-8?B?eFJoR2szbktEckdNeFhHcHNVRkpWOUpMcFZFbTlPb0FySHYzRzlqUGxVMGJJ?=
 =?utf-8?B?QUkwOVhCZDc3UTdDSTkrQkMveUdGbUxaZkEwK2NpdFM4NkppcVhleWJWZUZ5?=
 =?utf-8?B?anVSRUVZa1dSNy9md2pYeHRoWnRqYWR3Z1plbmRxVmdabGlpWnVGdFlaSEs5?=
 =?utf-8?B?U2U4Nno4WS9RbjBON0FxMEJWYWt1T3NyME13VC9idWc4K1grWXdUams1RUlY?=
 =?utf-8?B?aDlrN2t5SXZCZHVNTkxPSWhoSHpRbSs2Z21ueEZsRWFpYUdIQ2VrcHNIUzlJ?=
 =?utf-8?B?UXg3R1BIL25CYmVuN2J5MytZdExHMWwrQjRyNFpCaWJ1aXI1dzdHemM0RnZq?=
 =?utf-8?B?cHR6dGhKenptbysvcDErTUhSS1YrcTFWQ0xtWlNwV0cxM3RZbytKQzJ4VnNs?=
 =?utf-8?B?SytXR1VMV054YlRBaVQ3TWdGVTVtQjZyQ1F4ZEs1d0lTRm40SkUvYW1IUkQ2?=
 =?utf-8?B?NmRkcjNwbGdrNW1kMS8vSXQ0ZEdoOTVXL2pqMnY0UjlXWjhkVXg0ZTgrQ1JR?=
 =?utf-8?B?bFlVQmFPZWpOcnYyWVkzQnV2VXp2NzdNcUJ3aFBPZ2xrQWRWeGczNFZRQXBz?=
 =?utf-8?B?YVRBejZYVWlWc09lSWFibmZDOVJZaFRrZUhRTGZxOTdUb2FRNmJDdnVwNVNj?=
 =?utf-8?B?ZmpCV1d4bFFrQW4zdEdGUkxKUmRpVFpvbmhmSUZrR3YxZzFHbDQvc0tvZm54?=
 =?utf-8?B?RHJvMWZsNUJRZ1poa2p5dzM1cW9iTFJBM2sxbCtWTEY3TGllTThTdFlMR3kr?=
 =?utf-8?B?OWI2SWxXelJrYlVaV0hOb3g4cE93TXlUb1pERFlDTTRjaVFBSGxicjZhVUVZ?=
 =?utf-8?B?RGQ5RElhcTd1UjBtY1VXcnZRY1cyQXhyNTVoRkYyV1ZJbnZLeCt6YWRUWHZo?=
 =?utf-8?B?cEkxQTNqUGI2VkVzNkpJcnhvZU1tdGRIRUJnMEl0dUJSTWNySjFTcVJCS3ZH?=
 =?utf-8?B?VnBmV2xmNUJUb1lpNnBmSmV1bDZJVmQ2VHh6RVlQZHhSSmlwZENIMVpodE45?=
 =?utf-8?B?eGpsSlJJK3ZkeG9zRnk4a2ZJNG9xQWFmVm9PSFJEMVhGUitzdnFoNVRscFRs?=
 =?utf-8?B?L1kxbVowVk5rdXZKQWMvNGFEN3VYMS9IMVVUdWdNM1ZLbllMdGJ1U0M4SlhS?=
 =?utf-8?B?TDhaNXFZbnJUQTFlWFBzMEx5c0RlREs4bnFDR2FMMlVOcGVrUElZc3BFY05J?=
 =?utf-8?B?VGNBcUhqUVovTkJSQm1WbkdTb1JSeXNoWWc1eDJlekpQVzlTbkVEMzV0VU1Q?=
 =?utf-8?B?bTVoUU5nYkZpS0czb3FLbm1JUEZXWkk0TWduQStsZ2RpUkRCcWlxVEhlU0lN?=
 =?utf-8?B?OE1ZZGpIR3ZTbEEzQlZXcFNkbnJtNHFEOVk0ZjBJWFNHSUQxR2dPODZVcEpI?=
 =?utf-8?B?a2RNRS9YVW4xMEVUZzd1SFlFZW5aQnVJQUlEeFQySHF3NDFNMStYZlhHMjJK?=
 =?utf-8?B?OTBnZVFmZHZBR1c0WURBNHByN25HektEZGVTc1RMa0IzRGc1S1E2dFIwbW1u?=
 =?utf-8?B?REVTMWU4bmdIU0p3Vkd4SG1hVnpHdloxSjdxU1FkTjVDWEgwb051QWpycUJZ?=
 =?utf-8?B?MlpzRDJVVGt3ZDZnZER3TnJUVUMrR3FoRWNzdk45M1ZWeWhtYm4rYXlGY3VF?=
 =?utf-8?B?WDVDS2xOclJMUjd2UXFhY3VabUVYNTlxV0lLR0Y4UUVSYzMzQ1ZyTUM4aTl2?=
 =?utf-8?B?R0gxY3NKZDA1TE1ZTnVhc25IWlZlMTFHaUJQTDFRcjZyV2lwdU42YlZMM2JB?=
 =?utf-8?B?K3RWaTRPZFpwRDI5OEZ6c1g3L0RJaGV2MjFtbHZPT2I5aEFYaUV2ZjNraks2?=
 =?utf-8?B?WXdGVXVxWUpnPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:21:13.9409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caa7628f-910d-4326-f7d6-08dde6143c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173
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

