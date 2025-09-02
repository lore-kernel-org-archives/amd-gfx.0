Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76444CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2290110E061;
	Tue,  2 Sep 2025 14:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rQf8cjIW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437CD10E061
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPeVayK5D+UuMNR7wM67NjWr8NepElVASYwn0D0SxH+CWg+mXxKsXDXwmvpMuN1ifqMj9HWDHQBQzrMLpc5Y9zjwdmcGfuLHPrlDX3uklKXmK2wIPtxf9ado05ZIaCSPa2GL6DlUJb6y8MIpSwKGYKdCyMQQkg1/N2OUJoDHJfnz62qGwL5JW/kN5aUSlG4+n5AsSdnVmv1taChsT/7J+6mTaoK12sQFfusCYhOP8uuTcg0+bXTOSsziP4snOigZdmV5/UjZe01exL4hQFJm5rHKy1HFPKntnOj7fZ5M79A5Xm6reSQN12R4qw5THaHXYAZK2pPWoC4qNA1CgIUoWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ny6RJM7YQQT9H57g1gT3Zfz8z3CrQEpMLKh8CzsFHw=;
 b=rcsiZfiPqyNl+EDTdqGuxJFR6mAYWA5c8F676B+XL+HvC7jewdORuADMF4SaVPxIKTbeQOKFdlg2e9qPIVu+fBsaKnyMJzgNp+mIqUw2eXQr71ARXqJOHQ5uj/de4xSdKNlZngMbcNQTdLoJ47CwWDZE7+ICZTYnJFLGBtFIBXz/txjzid/lnlS7yGEwVp7XiVcQzhMCFkSmJLn+YDFMQ+TT0/rcJLv0XzcBbHwa562sQLi8lSvozC7Cjlyx1qaRQZ6u+V1Tmvh2/mitA8BbWsCUveay7inAOy5zytPSunY/93cufyLHdm7Rmqtj74JHZ2YQfnJauKsvzwmTH05NAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ny6RJM7YQQT9H57g1gT3Zfz8z3CrQEpMLKh8CzsFHw=;
 b=rQf8cjIWe1oUbyqFueeNCyWopg5/WTxHQgINg3eVifvMI30CrF6ObHkqzX3BCfvxMPpXUCW/UffsVl64XKJEDv+ZGitG46/OaPV/TxOO88guIFo7AxUPbJyfLHdSBATd9Snpt7wEGocP+MunyR6hv67wO+jpbEcn6R5PgpsogR4=
Received: from SA0PR11CA0027.namprd11.prod.outlook.com (2603:10b6:806:d3::32)
 by IA1PR12MB6532.namprd12.prod.outlook.com (2603:10b6:208:3a3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:52:31 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::bd) by SA0PR11CA0027.outlook.office365.com
 (2603:10b6:806:d3::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 14:52:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 14:52:30 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 09:52:29 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 07:52:27 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 0/8] drm/amdgpu: add MMIO-remap singleton BO for HDP flush
 v7
Date: Tue, 2 Sep 2025 20:22:05 +0530
Message-ID: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA1PR12MB6532:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e12ea40-1e5a-4095-d967-08ddea30579d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlJQeitWMDNmL2QvQVNVZk1Bb1d4Tlk5ZTdmd2RZcjhGT2RUUmxUN0tTelQv?=
 =?utf-8?B?blVSandqWGlrdXl4NHp4Q2toeS9aRy96bkkvYUNyeEtudjNQMEI5Mkh3ODhN?=
 =?utf-8?B?RXViYjBuRnZmWUZPR1lNNUhTaWdmSnBFSDE0UFhiVkNGSVhuQjRJNkVLYTBS?=
 =?utf-8?B?ZGd5ZStYU0l4ODlqTUpsYkNFYm9KanVoM3FKMzB6bW44ZXVmd2c1YzlzREI1?=
 =?utf-8?B?Nnh0SWdieG1BWnA5cXVaenFSRTRMS3FVTjRySGRmRys1Y3RxN0d3TmQxSjJ4?=
 =?utf-8?B?bERuT2FjQWxLbFprdUtYdUlwYVhNNzdRNnVrSEc1dllMYlpGTkIrVmxmVUdE?=
 =?utf-8?B?TjhROW5oR0RML2UxVVVISDNRRm84eTNVR0E1SVlaMUJjRDlHdk1hdzlFSXNU?=
 =?utf-8?B?VmJLbkM3b0FtY1RObnZCcjh2SUt1S1NmVVRYaFlMWVoxYVVRZGU2QlYyRVpn?=
 =?utf-8?B?WHRxcy9DTzZ4eHBqcHRqR25sY0c5S3JsT3ZqaG1tNjhDQ3VoWmJqNFNHbFVs?=
 =?utf-8?B?MWtVSDB5OFVNYVppUnE2MVJmTWVDbE9RdUhtVHJFSW1JOWg1aHVWT3MzdkZk?=
 =?utf-8?B?WExTeUh4QmpmelpTK0JhRHdvbUE1MU8ydnNJNkcvVkJQSk11NVJJdzBDb3Vh?=
 =?utf-8?B?dFFBamsxVFpCQU1YZTBaUXpYcG4wS0xTbnJEWFQzWDUwMzUwR0hzS3JUOE53?=
 =?utf-8?B?R1lGaGk0Wm81Q1lhNUVHSHdzbCtmdTM0cnpsUXJraWZQYStNYnIvdVdLN3B5?=
 =?utf-8?B?MGVDT2hWaXNFYW12QUlSZGs5UDdpcUZjOTdEQTcrbTM1R0d1Z2FWckdjOTNZ?=
 =?utf-8?B?MFZQVlFFbFA4ZE9pMkgrRkQ0NzNQdW1ZV2RvaVp4dVZtUVJXUitxWi9hV0Nl?=
 =?utf-8?B?WmZnSjhFTHZnR0dibHYyMW83MDZjWTRiT0hmRlBBRlY2UWE2U3p3MUhwK0ZF?=
 =?utf-8?B?OFNyb3VEUG54ZzdYNmhYMldLRElwL2V3dUdlclRGOEYvNzlJVThCY2hBMHVY?=
 =?utf-8?B?YkxucUFJTjV2SitrVWJKWWtrZ0hTL3AxbjZIaWUwNC9yTEtsdnkxd1A2dTVH?=
 =?utf-8?B?L2FMMHVRMnhGclFId3lLdEhuZXhOem5GK0xqMFdNRHV3T1dhY1FrWjZNcFAz?=
 =?utf-8?B?c0ZUWDdhNm0wS1EvSWVwOVdaWTRvZVBKV3RVV1VJK0NkeEhmZXdxRG5lWWlO?=
 =?utf-8?B?dTZYcFpiK0oydDJDRTBjcnVxdEdQNjIzb2NDa3lBbFhQV2h1SUJLQmk5VFU4?=
 =?utf-8?B?SVF4SGMrQXExOFBHdjBwU2dFR0tJaTI2azgzNEc2TDJEMlFnam90enRCTlhW?=
 =?utf-8?B?a1lHQVpxOTdNNVJlU2ZjeXlPRTJZMlhtUndLNCt6NkpiM2Rxb0pYR0wzK21E?=
 =?utf-8?B?WStabkVyZWwrTjI1QkJTeWkrRUxoNEp4cDRUaFladDFlODEzRHY0V3JCT291?=
 =?utf-8?B?eDAzcWQvNU9UclJ0UDQ4TzZjZEc1d0dpM0hvYzR4ZUFUY055dGFsZFZNMERj?=
 =?utf-8?B?ZURWT3pEa2VnMHF1QXgxaFYvMFFqVkdObWVCaTVPTXduKzNpUjdteGFiTWY2?=
 =?utf-8?B?bFZWSGhaUUJZSFcwY1ltaXFxSHRTWEFhSktLdit1Yk80TUFmUDFLdXhKNmtD?=
 =?utf-8?B?elJqK0Y0bDV3dHFKeFJFV25JQmYxTzBNYzc3REtkNG1SalNmc2dCVmJyV2M2?=
 =?utf-8?B?UkJXU1ZDc0M0MFNMZWt4NkRHNDByUDllbm91N3FqdnZVdUVwR0paOE1tb3Qz?=
 =?utf-8?B?TzU2eTR6MzJmVC9jcHRiQ1BBdklnK1BpRTZSRUorRXozWGlzSlhKTmtRTHps?=
 =?utf-8?B?ZVVqckhXbG9mWHk0eEp4dFRGOVdZR2ZSbm1EUE4rY1JzVmZMaGErc3d6Tzhh?=
 =?utf-8?B?eExocjF6TFYyR255bitDajlTMGM2bHBleTJ0dUorMFJJb2dCU0dsTERJd2hC?=
 =?utf-8?B?blp5MmtweGlJSmw4azlaSjhacDJ5SmRLdzc5SzE1Wlg1VmJHTmhYeUhXZXZE?=
 =?utf-8?B?cTd2MlBJeXp3PT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:52:30.4373 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e12ea40-1e5a-4095-d967-08ddea30579d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6532
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

v7: Updated review comments from v6. (Christian)
https://patchwork.freedesktop.org/series/153209/#rev4

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

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 57 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 87 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +-
 include/drm/ttm/ttm_resource.h                |  2 +-
 include/uapi/drm/amdgpu_drm.h                 |  8 +-
 10 files changed, 169 insertions(+), 7 deletions(-)

