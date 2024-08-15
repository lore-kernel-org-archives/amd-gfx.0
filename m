Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F5EC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1778910E321;
	Thu, 15 Aug 2024 00:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JF53/Tm5";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0B210E321
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ewippNDR91dPiz3OoOj04cwCbTO1bZdFO/Ptf/UnEK1t13/6T1YAmZYNGrovXH4AeJN6JZxn98BJezWBmC8mtxysC7EGWxUHaGe/ncNjxdouH8qtAFcrZ2D4MDqAAW20Hd5d/kuEs5/Tb7GpYjA/tYqiyrteXrFJZInikIFMci9TqTfySnTT5s391i/3BVDYjlMBdTgi//CMIM6Wa18otZ6Vi/2Jcu7ClkKC5PKm5XSQev/dGsA1Unkj56/A4AFKu1AiMFipbuKoLnLNAm0HfAMevXSHHk0gL8SeVFG32ldeDT/jdN+Rpc4jq1deQsAMKjkgWB/E3MACoTJrhyHmUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyDlaVKL0EyzqYe/9RT8B33UEhITqepAi83r9OlCyWA=;
 b=NDDAn4sbT8RKdppaWMxcOivHIKWVf4vlubraDAXEQNNgxljx7otE568TNDMEIcJNjA04H1YUWiq1CFJcECKI2Z2p/Y+vs5F+FNQ23dvvSCM6rA8Udkqn/XAcVmCBH3NiGYMVVy2I46jzU4YkDYaKKk8gZpriEReLwKhQtm6oMFwFoMHJdU3h7F3UT3WeKtIgbeGoQuDoXsTkCbYwRscJ765/jH4Y1Gj+9sHlyHyvY8XK0Zf9LYjQuvlcnWYzx1VxXiVQpX6+Q5f5M12N192FymsQ7Ekrs1Uzz05SuZSBUjgMHWuhg30JGGYXb5f3plXbUQUrsCeWx8UUciXfiiqDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyDlaVKL0EyzqYe/9RT8B33UEhITqepAi83r9OlCyWA=;
 b=JF53/Tm5WDsCUAdkm+KUeH7VIpR4zsZQ5r3sN2Kz1FCbK08lZtqnwFswtifLWlol1kV9n5xXmKxqYOybYEnhY248NSdsw1dfB3Z0WmPJX23KplhUU1rDnW5qYp4UN9vZ1xp/iEV3SweXctaNhJZvGVpOIX9pPiNwhD39NzGA3uI=
Received: from BL0PR0102CA0016.prod.exchangelabs.com (2603:10b6:207:18::29) by
 LV2PR12MB5944.namprd12.prod.outlook.com (2603:10b6:408:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 00:05:18 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:207:18:cafe::63) by BL0PR0102CA0016.outlook.office365.com
 (2603:10b6:207:18::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:18 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:17 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 00/17] Process Isolation Support
Date: Wed, 14 Aug 2024 20:04:44 -0400
Message-ID: <20240815000501.1845226-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|LV2PR12MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3fa1b2-ae3b-4f44-32fa-08dcbcbdf27b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WUJ5bFh5QjRXaVl1UXVxYzdIeE9QRElEdzJ5d2hNRXYra1dieTlKREZ5VXpG?=
 =?utf-8?B?VDExVzE4d0M5Mk10bjdxRmcyWHlDNk8rNDgzQkJBWU5MZnRGYkplbU1NaEhE?=
 =?utf-8?B?TDNsMVlBMFFrSUNUeHY3RUJnVWdqQzFkM2VTaEtsQnF0M0x3V2hseTJQNWhz?=
 =?utf-8?B?NEFyQjBIVVp1bFM2OUgrNFFjVkFsSHc3dWpFd21kNWNLTlBFTXJDVC9PYUtl?=
 =?utf-8?B?Wnp3MDVFeFdpUHN3OUdZRkZHRmFvc0hSUEVqdS9PUzlVRmN6M3dWekJiL0dE?=
 =?utf-8?B?UW1LMGh5akdQYWIzdHFTWW83MzVCeGk4dDczZVJhaVBwZmJObWhUdHdyaGlh?=
 =?utf-8?B?QXBDNGwwSDZTWXprK3dPQjgrZ2oyam9VZGhFcTJjQXVWbmQ0ZU9kUm1GbFkv?=
 =?utf-8?B?aGVUSDFlY1hPT3dUOEZQa0NkeGV0QWpiRkVaaDl4R2RvT2cwVW5hc1E3WVJq?=
 =?utf-8?B?bU1kTzdXZnFsNjFDOTliakRUNll6VzQ5S3dFaW9pTUVrL2JrejhXdzlJcVFo?=
 =?utf-8?B?Z3h3WU1YRmQyak9OTGZFT3poL0p1cUxhUXZZbzFMUjVpMTY1emdscnM0blBn?=
 =?utf-8?B?WExuTFdaTFpsQTllRTYxZE1lSlBQTnk0NU85VGg5VVc4N1c3N2VDM2tkc3hJ?=
 =?utf-8?B?WW5SWGFoYXNNVkdPZUNwK2NST3FHb0pKd1V1NmNEWWJUU1l0a1lMSUZTNk5T?=
 =?utf-8?B?U1VGc0gvNGoyZ1NKZlJwMkR6WmUxZHNpMVVJOWNQWVFzRTJBd2JGVjRHZjha?=
 =?utf-8?B?dUVoa3ZRWTU2N2pyeENBaUMvdENKK1k1U2tFVGNHcytrQStSNURBQTVXTG8x?=
 =?utf-8?B?K2FOeEZjSkNKdUlnN2lKbngwTHUwclR0WkhMemJiUm5UZjBZN2FHT0lLL3NC?=
 =?utf-8?B?SHRyQ290OURpSFlVN0E1WE9IYnRhRTdGZjF0anY4OFRWZlRPVFRUWERyQXl4?=
 =?utf-8?B?Ny9rNEZOeS9WZjZ4SnFXRkFFN0YvL3FlemV6dUhIdkEwVVdiam5JcVdBelMz?=
 =?utf-8?B?NTBnS05NU3dlVERRMlFUWmVpNTE3WG5aa0xKbU9OYWlHeTNZUy9icWNXZXNz?=
 =?utf-8?B?K2o1YjFmZG51bnBsVTlvdTV6ZzNoLzZ0WDZBRW5tYyswSC9QUzZocXRvSXBS?=
 =?utf-8?B?YjZuVWNWa1hwMmxoamRaemFSMlJsd3dOQW5xNG9JQmtJaENOV1pldk1EaGw3?=
 =?utf-8?B?bHpPaFZySEVOc0ovWEpRYTdETUF4Tm9UQmtOUFp4YXB0MDhGazc3b2RBYVdB?=
 =?utf-8?B?RCtoYlEzY3ZYUThlRFJ1Qmx1dWxpaDBUd1BnUGU0R0pybnUyMS9hUlpkY2lU?=
 =?utf-8?B?REh5YmtEZWxJRGtxTGU5NENESFpqZGZDbEZkQktmVWlDejVwUU5PQWRPc0FF?=
 =?utf-8?B?VEVpZTFOTWtoNWY4d2ptZ1FiVVNiUVA1ZXRkRURqNHFhdml1c202RmViQjR6?=
 =?utf-8?B?ZWJhTUhCdk1wU3NVZTRveUYwbEduQWNuZGdtZ1dGSzVFRFpEUXBwV2lSUzlF?=
 =?utf-8?B?YjNSSC84K1Q5UkdNYWo5aHlZRjZpejNJd295REhWN3crOUVkak5ueHJHZmYw?=
 =?utf-8?B?U2VSMU1VSWRiVTczVFQ0aHljdERlSzlDdEhiVm9UQi9Zc01DZGw5ZjN4aDBQ?=
 =?utf-8?B?WkxlRnhuYWlLN2psQkdYQVNmN0daRlV2RVJrOGkrNVl1TFZSbnp5SzlqMmxZ?=
 =?utf-8?B?VDNIWnJ2Qkt6VHNGbHROSFFabk5zN3hMSzRMTUNhOUpMZUFsMEJFY1ZjY2I2?=
 =?utf-8?B?NTBWN1FyKzhYdWdlVGhvVlRjY2UwSUl2VGZMZGNWRW9GbUpwMVZZNnlxcGNG?=
 =?utf-8?B?TDVrUC9yaHQwbElTcGZXN2EyK3c5V0V4Q0FRbDloL1dhdGFkK3ltYzFZV05l?=
 =?utf-8?B?d0RvOWV5VTJXUDlsdWdTdVRuUTVKWlltQUdRWDdHdjFxZjJWYnliN1NmNm41?=
 =?utf-8?Q?tSINbkp8T3TsvUcYwx+8CboKkXn1pru0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:18.2143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3fa1b2-ae3b-4f44-32fa-08dcbcbdf27b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5944
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

This patch set enables process isolation mode which
serializes access to the graphics block between processes.
When this mode is active, a cleaner shader is run between
processes to clear shader LDS (Local Data Store) and GPRs
(General Purpose Registers).  A sysfs interface is
also available to manually clear LDS and GPRs if you
for example want to clear LDS and GPRs when a user logs out.

This includes support for GFX 9.4.3 and 9.4.4.  Support for
other GPUs is in progress and will be available when ready.

Alex Deucher (2):
  drm/amdgpu: handle enforce isolation on non-0 gfxhub
  drm/amdgpu: Emit cleaner shader at end of IB submission

Amber Lin (2):
  drm/amdkfd: APIs to stop/start KFD scheduling
  drm/amdkfd: Enable processes isolation on gfx9

Srinivasan Shanmugam (13):
  drm/amdgpu: Add infrastructure for Cleaner Shader feature
  drm/amdgpu: Make enforce_isolation setting per GPU
  drm/amdgpu: Enforce isolation as part of the job
  drm/amdgpu: Add enforce_isolation sysfs attribute
  drm/amdgpu: Add sysfs interface for running cleaner shader
  drm/amdgpu: Add PACKET3_RUN_CLEANER_SHADER for cleaner shader
    execution
  drm/amdgpu/gfx9: Implement cleaner shader support for GFX9 hardware
  drm/amdgpu/gfx9: Implement cleaner shader support for GFX9.4.3
    hardware
  drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.3
  drm/amdgpu/gfx9: Add cleaner shader support for GFX9.4.4 hardware
  drm/amdgpu: Implement Enforce Isolation Handler for KGD/KFD
    serialization
  drm/amdgpu/gfx9: Apply Isolation Enforcement to GFX & Compute rings
  drm/amdgpu/gfx_v9_4_3: Apply Isolation Enforcement to GFX & Compute
    rings

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  18 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  14 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  23 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 437 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  31 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c       |  17 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.h       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   6 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |   4 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  51 +-
 .../drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h  |  26 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  60 ++-
 .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 153 ++++++
 .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.h    |  64 +++
 drivers/gpu/drm/amd/amdgpu/soc15d.h           |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  39 ++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  58 ++-
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |   9 +
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |  14 +-
 .../gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h   |   5 +-
 .../amd/amdkfd/kfd_pm4_headers_aldebaran.h    |   2 +-
 25 files changed, 1028 insertions(+), 23 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.h

-- 
2.46.0

