Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BACCA0EFA
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C50CC10E19F;
	Sat, 23 Aug 2025 07:20:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yFX1KUrd";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 422B210E19F
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp9iTelngn1/PxL5DWZ80qJJRc9ZAHtPX/7XMK9sBYJt3wi33FhE9g9TCh2IzqCSZgi0EqCKriwE/Y/NMeZMovvb0pcoMqLz08z0U4Ova5YQTzlVQziQ+CRVB20kJWFypqA+rWXRwN+n1DOvprUPm6g/k6jU1ZN9lUIguhzCuo8Cqr5uEspScNsR3INWg6cjd16FA0CTWm62QqBc8nO9bRpVbqIuao1BgiSDX7xy4w7uY905VyYHm5IO6CbElhvLF9VmnlLwXnD6b6FyLbIUhqyBzg86nqIJJXtjRo4lo0u7dxsxZAeiiB8LGtV0sTU3Vty4s/sdNvLgt01xo8VM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIZuaszTz61u+mJHzeckZoyi9F1E8B+lqFb/VyeoaS0=;
 b=YCbpU3SpWwjCz94Ti8vfe9A+Doh8Tqd1KA6ktGvycapF6GnXu2+XkWD6FeIIFm0MLnokApU/jXGhw7YXGcX/hjT7qzCsYKQFT9scvEdw1FqA1OZS5Stt6u437heCYmTNn6TWH59iPLX7ZbZwLVmMioXjp839milKIrCXlE/5eD7xD1ZypPpYX0nqyaF0xy3OQRCPBaLUM1iOuuhjReIHgKB2aQs1tZEaJGQlw7mgSqTmpvQu4z1V4srow6q8T1cdLYhp+vwGM+cliirXCknCzG0tH00ZGN2gUpZrS6MdAfIhWpJM4laBZNr+PTbVU/5Ryu/PbEeOui/Cf4GQAnfTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIZuaszTz61u+mJHzeckZoyi9F1E8B+lqFb/VyeoaS0=;
 b=yFX1KUrdA3+ot+d9RlDnjXVfRIdsiomPUGeAd5h1i2E5xXN22FXV2/WmznGhZDaGoJ2/IJXDvIR2959qkxOkTfv82ALsNMiKzLIlyAxk9ymLYJUxSF/xh31WW4G1+MXG4pI8ncNdP2R/fMrV9Nx8YZ1ZbU4XU7/UNiI45DIY2D4=
Received: from SA1PR04CA0022.namprd04.prod.outlook.com (2603:10b6:806:2ce::17)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Sat, 23 Aug
 2025 07:20:34 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::53) by SA1PR04CA0022.outlook.office365.com
 (2603:10b6:806:2ce::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 07:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 0/8] drm/amdgpu: Add MMIO-remap Singleton BO for HDP
 flush
Date: Sat, 23 Aug 2025 12:50:08 +0530
Message-ID: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 70464381-9623-47e2-d935-08dde2158cb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1U2eE1GWEFOVHZFcVEvVHNPRWlobnZSV3NRdUI3SjZrWlQ1SnJJemlXTVRm?=
 =?utf-8?B?eFBYWlVhWXBKTE42R0tnMU96amNSVGhTYkNpYjRmOTMxbjJHZkpGb2V2SEV4?=
 =?utf-8?B?RFg5NE5XendRYlZKeVdhSkRub002WFVVRGNoci9sMXozVUhuUVZrOFRvN1Q0?=
 =?utf-8?B?dVZwOTVMOUZzQkNLZUJSek1VQmM0dW94VWZQNWU3QjdibENCejBJa2U5ZEw5?=
 =?utf-8?B?eHJCTmpTczNkZU12dmhZMm81NmFPU0dCblNaNWExdVRWWi9WMEgxNDNPb25Z?=
 =?utf-8?B?VkFQTnpRQzhnRVlzd0JvbmlvelQ2OFh2WVdPUFk0NmgrYWswUVJINWVEQ0xw?=
 =?utf-8?B?Uytkd1kvcUxZc0NoeGhNM3FHejgzaE9MZERRdkx0ekVHRUZLYmVrbzRBdXNz?=
 =?utf-8?B?ZVhiaGdyaWZtNVpWWU5URkNVaXlFbHk2bzNSSHgvSVdvREhjQUtrQkxFRUs1?=
 =?utf-8?B?amptbk5YaW84MjVCUlF5a1NhdzNUZml3YVR4SXBGaUxmbkdUZlZmVEdSeTR0?=
 =?utf-8?B?ZWdnbGRPRURpUnRIYVRBbEh6MC9YbHJwZ203ZnQwVDFuWnE2ZHZuL01zUkR0?=
 =?utf-8?B?Q1dWNE1EalBWRVdJSDYzbFhFOVVEcUZFN29zd2J4NnpXbkp6SkRmRVgwQ0xB?=
 =?utf-8?B?NzRSSUQ0NWZsWWtiQ1NkNEl5VW9mOGhaYWo1Vk91ZFRmL2pMQ2swRXk0MzJy?=
 =?utf-8?B?Um0yY3JramhFWWN2YkhYYy85bG1rZTBxeUJJR2lDWkk3eDhkL1lITGRpQU1x?=
 =?utf-8?B?N21DUHVBcTJ2YStvNitVenhGSWZ3d1dFSWlnVVN2K2pKd0F3ZjV3UFNad1pj?=
 =?utf-8?B?WXFwWmxxUi94U3l6dDNRd2ZpUTVsc25aSUpodk5LMllVL3dwcFZHa3kyS1RO?=
 =?utf-8?B?QUgzNm1KdmxFWU1NalFmSi9pOTBlRk9tbTkxT1lHNXZhVzhodzIrd3ZWem4w?=
 =?utf-8?B?d0xFNmhLajNaMmp1eVR5ZHF6cXZNdWFGaGQ1UDlpcW9IVlNuWTBLZGhvTWp2?=
 =?utf-8?B?ZkpQSjdJdTRjKzlQNmJad2lSanZPT3djTWhrbXJRNzZtMmNMQ3hwa1c0c0pY?=
 =?utf-8?B?cTZVV2t6cnRMZ0dPMTRJRFhZUXFGYjZzSkRiaFVNNzFwQW9GTjZPcUNrRWt3?=
 =?utf-8?B?OW4yZDNjaFoyNWt4MEhscUNQbkNTM095QzBObUUzOHVnODBReENEV1FiQVdI?=
 =?utf-8?B?Vng1VVpHMlNxbTRHQ05CUlRRQWU2ODVQVFZLQ0Z3NFM0d25BVGVmdXZxSGJx?=
 =?utf-8?B?QUlwdU8vL0k1ZmwvNlpQclhFc2lvdTdtVDQwV09CNkYrblFXeFFBcEpBdHR0?=
 =?utf-8?B?WGJLaThzd3B1MXNhcEUzc1lXRXZrbUtGNlpKN2xlaWNLMlVlTmJzSU11ZHhm?=
 =?utf-8?B?bFA1YUMzQnl3VkZMUDlIb0dIN09qZitlaEJsUHRWOGFlczhCTTh4OFg4Rmtp?=
 =?utf-8?B?dHdlVmFFWU00MnlWd21CY2F2eVAzdUk2NkQrdlNZMjd2VmpQcE9ybFllaXpj?=
 =?utf-8?B?QjJEeHh0OGZoZG84elpiRWpEQTNlRHdyZkxkejNqWkNFQ1FGd2FJTStBTDBW?=
 =?utf-8?B?cnY3QVN0dUFzVlg2MEVVUjZrN1JmT3VIVHNzK0VkOGw3dklFZ0hYWVdGSjVY?=
 =?utf-8?B?aDdDVmR2ODlLeEVYUE1tbHkxeFFDU24rbnNoVFIvS3hDeElVOUNpa0tHa0NL?=
 =?utf-8?B?dERkcjZRTnBLUjVsdGJsVTREZ0JxTGtrUkMraGhqRU05VFlDcVQwMHFhYURU?=
 =?utf-8?B?dFZBUzBnRmpuSG5jRlBhYUtoVHNEY3QvNTZBdTRWSnowK3VMNm9TazB5QTls?=
 =?utf-8?B?eUVoRmh6MkxGSWIrMTludjZ2d0xkL0FmVmtXWlk0MCt6R3N4SEs2Y0g4Vks5?=
 =?utf-8?B?R2R4a0EvOE1haXlQZEFiUVNhL05PZkNUZWtZelFaZVpJU2xpTTFBVWI5WS9I?=
 =?utf-8?B?OG56bjFFcjhtV3RJd1VDVmZheHluSk1uYVNTWStuTnRKeGdDc21tUllGQkh4?=
 =?utf-8?B?bmtHSGl6c283NlVXT1lRSFY1QlRrWXJocHgwakFxdkxjMUtzM1NzY0UxU0h6?=
 =?utf-8?Q?wgAnVn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:33.8881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70464381-9623-47e2-d935-08dde2158cb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640
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

Design
------
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

v2: Updated review comments from v1. (Alex/Christian)

* Only compilation tested so far (x86_64, defconfig + amdgpu enabled).

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>

Srinivasan Shanmugam (8):
  drm/amdgpu/uapi: Introduce AMDGPU_GEM_DOMAIN_MMIO_REMAP
  drm/amdgpu/ttm: Add New AMDGPU_PL_MMIO_REMAP Placement
  drm/amdgpu: Wire up MMIO_REMAP placement and User-visible strings
  drm/amdgpu: Add mmio_remap bookkeeping to amdgpu_device
  drm/amdgpu: Implement TTM handling for MMIO_REMAP placement
  drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
  drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton BO
  drm/amdgpu/gem: Return Handle to MMIO_REMAP Singleton in GEM_CREATE

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 62 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 13 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 +
 .../gpu/drm/amd/amdgpu/amdgpu_res_cursor.h    |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 96 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +-
 include/drm/ttm/ttm_resource.h                |  2 +-
 include/uapi/drm/amdgpu_drm.h                 |  8 +-
 10 files changed, 183 insertions(+), 7 deletions(-)


base-commit: 6b70b6008d812a9a210455dd55459a21279bad1e
-- 
2.34.1

