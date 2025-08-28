Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B98B9C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E5DC10E940;
	Thu, 28 Aug 2025 09:15:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TbPWmf3v";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2048.outbound.protection.outlook.com [40.107.100.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 383DD10E93C
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2shbmnjgzkjEK0nH74niv5q/OXrZN9YNc+VHkUuKeBepYaZQ9YCUHAWRbCVmcKFd/InqdjR7qI3IXgRObXg2jJ7dIOvishHlJ5boQt/Q9ynuEAgOnsPbivWC4/m4aQzE8JaOAo6bh+cMpC7PLIurORKNoWszhencELVYu0BkPkUwI01ulbscz6CE5+vhYCM9u5XeN2gA6JlKKdPQnG+J4nFNVrhI3aUUBjTPj6VuUTI5h60Ll4QT08TjC9+AYQ4BQF2G6XkGXPbA/LvrVCfKgh9EqEObrpI8x8FhiCJx8kPImdgGGiDGmLe0Y/xFlYHsxcDX/cQ43h0YcLspU5/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hwhk//pA/dKfI/Mo+liWPOJo5Dn069UOWGFlJbdmGnM=;
 b=TssihQbXx7iY606f3ttFOflmoWYqks4/nsfBYtZGM/GMDqaK9iiKM01E04sdz/i9C9Uxqiy0wi/9e0qQUwIjKnrv/EfZKtxl5w8pfi6F+ib67iQ4SbH1J7nqokNdLwUI75ER7YtZjHutBVNG+gRPXmZ4jbWO+N4aQaf02eEn7X3QqGTykusXLhcc0ytlDOD5qEzp0r0iE60l52N+XHsQYZEDKmWGi2PjP3qcEbj79la2OBL5iss8c9aF0XdHHJVAY/Pf06sXNeiP6d+3GQy/kZ8co/KSAWv20oXGoPuD15cNLOeFV+BTmdT1ItReQbcQoISoBWj7FRaIEaFriH3qRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hwhk//pA/dKfI/Mo+liWPOJo5Dn069UOWGFlJbdmGnM=;
 b=TbPWmf3v3MwcKIW9LijJi9XvXZBEAmEkPc+2M80eDFYYDQTvmb7S2yWT8fPRT1MOe3HI3fujlu5JZk1VXTU6XddO8mGL9EztEEbVvzcUklURVkRnLi1HkGQsTE5XN+fxoa9TzlU+C6RkA8wzT2E462VUI17l/0fvXLilo4MG/NY=
Received: from CH0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:610:32::10)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:15:35 +0000
Received: from CH2PEPF00000099.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::94) by CH0PR07CA0005.outlook.office365.com
 (2603:10b6:610:32::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:15:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000099.mail.protection.outlook.com (10.167.244.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:45:50 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 0/9] drm/amdgpu: Add MMIO-remap Singleton BO for HDP flush
 v3
Date: Thu, 28 Aug 2025 12:15:21 +0530
Message-ID: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000099:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 413f6d5f-6cbb-473f-dcb5-08dde6137235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTMzMjFaZUVlOTc2K0VVWHc4b0hEOWhoY0lqQTAvdllZRnZ6YkV5dTJyQTkz?=
 =?utf-8?B?cnpBWnNGVVd0TEVaZWZ0V2JMZExISzdPSWNnTGxRcHVud2VLQkRrNVFaSjEz?=
 =?utf-8?B?OXhNMys0YVJUbVFESzZublZOOHFIa0g2NDl6RTJPWEQ4N0FJSW9Pa0pDdXFL?=
 =?utf-8?B?RlByTnZwZ1kzUGFRTVpCYjdWMUxZS2lrdzgxdEI2VS84YW83V2NGQTVYMnFS?=
 =?utf-8?B?djJVMEZGV0FVL2VYSVFPbE5PdmNpODhNd0hOMkFQZ0FEaWNKZlg4YzRXQnUr?=
 =?utf-8?B?empLMWF5OE1HLzhkSW1PNEt4UmdrMHN3M3V1L0tJenVXVDg5V1IwSHhBQklM?=
 =?utf-8?B?eVpRYUpwWjkrR2Q3WGEzc1RlRjNKSGlqNWVaK1NxVTQ2UDkrUkNtVnVEdTZ2?=
 =?utf-8?B?aUJFWEJqWGxTWWlsckxOVkVNVEJmZjYrNkJhelVCTVE2VlVpRDZGQjJad2pt?=
 =?utf-8?B?dy8xbDU1djFIV1FlcGc2SFRLZWtaSXFpRTJLOHpWWUxtNE90blZIRlVveTdq?=
 =?utf-8?B?dVNKZkhzMlEvQ3djVlU2a2wveXdsKzlUL08rdHk4NnpSSDd6UC9wVjlSOEtD?=
 =?utf-8?B?dTY1N2FVZUlkSTRUZFpWMElHTHNqbS82cnV0eTZ1YXRnMHdocjFaQVlJMEZZ?=
 =?utf-8?B?WnlkMndwc2lQa0puN1l0OS84b2dGaVgzN3JsS2NyT0RrVWlzRm1rTUkxRGNy?=
 =?utf-8?B?eHl2SUhCZE9OcmlTdU9aVW9oZDJmTHd1SHJnTGUyTjlEM0dzdTB0R21mTEZE?=
 =?utf-8?B?YUZNcXJHMHVhbFJTR0xuWjZRekdyODM0Z1hBMWEvTzNpaFJjNEZvdlhvVHlO?=
 =?utf-8?B?MmFNNE11enNTcGVJM1djRTRFaFFZckxWbjZTRVlHVlpsWDhjckJTc1NGS1Bm?=
 =?utf-8?B?a3VMdzdydVliZzRRU09iZkgyZ2I3LzlYTU9KbDlheDFOSCtmdUZ6Z2hGa3hR?=
 =?utf-8?B?THA1S0FsakpGZ0lSZERpdkRwQWN3S0VwRFdDVDZiOUc5ZEJmMTV2bmZrS2sz?=
 =?utf-8?B?Tjc5Mlc2MlE0bklWWTdZRXJ6cDU3RFBMc0taZWVOY1JKbzFYNjhYMGRMb3JY?=
 =?utf-8?B?a3krTEhPdW0xZnV1VWllbjBiaEl6elFoS2ZpUGVoTnR2ZHR1elNwRFRZOVd5?=
 =?utf-8?B?NEF0ZWE2RmdyQ1NqbzZqQmpGYTB0alY0bmVYUUU5V0NkcTFkY2VHOU5PdEkz?=
 =?utf-8?B?T2RQU2ova0puUm53TnovMFprbzdHdHQzTDd3cm5Pa0pOc2VFZHZLY05WbFh0?=
 =?utf-8?B?ZVFsaUdJU3R1cTl0WklvVHRXcFNnZ1VEbWVOWndlN29GMGRVVUFxVEJ1QVNI?=
 =?utf-8?B?aDFvcFNPSVcxM2ZBRFVDRXdhdE9RLzQ0cTErOTllOTBjeldlUUxIeTg5aWpT?=
 =?utf-8?B?RmVoK2hHOW1HWHF4N2xMWXBkNW1VR09qN281RCtmZjVWa2U0RllZRHk1Z0VC?=
 =?utf-8?B?L3A3OGF2OFgxREtpVThKSUtqQUVVc0F4RENPNzJSSkQ0N1BDTDRiT1UwbFFs?=
 =?utf-8?B?Z0ozeUpMUVdITElvUmxEUldkWWtUQXppQXFqRzVqTUNMUDJidEFPSU4ySWNR?=
 =?utf-8?B?ZmtsSVQ5WDlKTnVWem9LNzRZS2pidVhkMURwOVphaUYvTGMrV0xCc2czSmUr?=
 =?utf-8?B?QWRTdENkNmhGSGgyekp6UGJEMCtoRkp4Q21KN05tSWVLWHYxYjNoeVh6amFP?=
 =?utf-8?B?aHJnaVdXRlRBR25MSzhxZmVIVUpPdnA0ZE1CeEZ6ek5FUmszNmtIekU4T0gv?=
 =?utf-8?B?dHRMMHI5VGN6ZDlKd3grc3FIMXROejhDeXdpUWxkRnE1aW9Iamxrc094OXpp?=
 =?utf-8?B?WTJSNE5KV0prRnJkajdHdC9NcXhkMGtMZXVHNGdyNUJqZ3hxK1NocGJmVEdJ?=
 =?utf-8?B?aG95dENlSVFNcWRTcnNRa21wbEVJc1RMRHV1S200ZkFtVGNmakhLQjZVR1l4?=
 =?utf-8?B?QVJUaVZMMytiNllOYUN3d2N2WUZiY2d1SUdZZWlYNlBWZXpPa1pPcXRuUHRh?=
 =?utf-8?B?NURkY0k4WWVRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:35.0839 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 413f6d5f-6cbb-473f-dcb5-08dde6137235
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000099.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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

v3: Update review comments from v2. (Alex/Christian)
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

