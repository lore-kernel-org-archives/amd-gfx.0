Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927D1CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 14:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 356EC10E787;
	Tue,  2 Sep 2025 14:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rnAkB7zN";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642FE10E785
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 14:59:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/7qDtcEHZFsX8P9bfCB7bC/FWfJx0iZqCCLw2VaYn1HOIYSNvhY/JJchji3r6xv2YcZe4VjP9vYAFCvCn4GeG+NiJpxnj6v9XaznS8NqdbzmnVyl0OgptKW2b+tPxk3dF+miSRAqzsWPfxrXYwN1Qog96sD5zJLwVpdu0nkOgtabEtsp0I5DuYhBae/HpSylBZlE7kFLKLzQNmOUzDy/W2bBlT10Mi+passcTLDnFOtcAhJUWKQ1nT5EbY7jdiMGaqHgKrkwV/fwpIH9/UqbPJp4X6wGZMPm9BCjWWbwLM1NY+XbFuNRcg8vkPYvVJEQ82CPmUWMcU8ZY8FYMik4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPn5YMS7oNbnzySnktduM/Y+F46hAuXBvYWO0Sj4leU=;
 b=PkhgDcHAvWlRXIYh53TXNtz8+ULzKwBMETRmWmWRfZz9dln/jlF8uuyfwe74+dlDjXX3YUcwlDcBEU/ouT9Amwadvd4wLKBTLfobIvWjYJHWB1Y3a8QFP30EEbw4qvv3iFv2KHZC9IgSk+zJbI9qgEoQERGnIEXk0H8eDJ2V/sZa15YniPkTaqTWvrtbHKrl5hV2nVtudIbSXbF8mn326uKZmwf7fjg2ARZveqhb7KbwafarupIgFmr6DJA5vDB5+vyJl/0X3sMXFZt5TgWHDHr8GJRQXrtEm/dr/roidb+NTxMcHE5NivsgUeu/rs2Zy+xHpm5AhoN4LIzFqgjT4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPn5YMS7oNbnzySnktduM/Y+F46hAuXBvYWO0Sj4leU=;
 b=rnAkB7zNCEX5Pd4n7MAhjLk3NlO+F8l7MmzgbZ7mAkV77Ga2sqWnJKLCxRu7QExPjHqSU7GIXcF4NlJjkZiaQMZQegppKC2T5Tlio1+xKJUE1+gKwYsn8a5NXv8GPJes9oQcV+BxPZcDCRbKjMJKNJpteUberb3dpVHJq5jfD90=
Received: from BN9PR03CA0439.namprd03.prod.outlook.com (2603:10b6:408:113::24)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 14:59:35 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::44) by BN9PR03CA0439.outlook.office365.com
 (2603:10b6:408:113::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 14:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 14:59:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 09:59:34 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 07:59:32 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 6/8] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
Date: Tue, 2 Sep 2025 20:22:11 +0530
Message-ID: <20250902145213.486199-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
References: <20250902145213.486199-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: 585f6828-c992-4b16-0973-08ddea315473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TEo5ZjQ5RDVDeThYbmxRbEhzU2F1K3dhcnJoc0p2SlFuT2xQZXhkNy9oUG50?=
 =?utf-8?B?Sjg0Wk1uVHFPZkZyS3VhS3Vyc0hPQlpHZ0U2S0JxQThmUXg0Z3lseFk1QUJG?=
 =?utf-8?B?OGtLMkU1VS82MHpaQnRFOVNJbmg2TG9CWDZMOEo1KzhJaHk1emhMNFhmYmh4?=
 =?utf-8?B?c2ZsbGhpYVRwU1l4SU8xNXN4cExMUUJ3ZnM2LzA0MXVxL1JKd3NJSC9hbEtH?=
 =?utf-8?B?NTNXQ3o5M05GdnBNT3JJVnNLNDZKMXdiWGhIWFR1a2dIQ2hSVTdMUE8rdnBO?=
 =?utf-8?B?WGViV1FuVkRHTkRFSmF3YzJ1a2hNTHJlYUQzR0xEYXJDRU5Lcyt0TVU2K0xM?=
 =?utf-8?B?VlBDQjZnckdLYlA0Vjgzbzh4OVl1Q3cvOS9QVXU2YUlzbHB4VTZWZnluUDll?=
 =?utf-8?B?S2hGTlc4bHVzZmUrWXlqL2dtZWdobC84bWljdm9DbjV4akR5VTFGTDN6bVM4?=
 =?utf-8?B?YUkwQmJaV2RjbWdyNkRaOTZzKzNTNWRHbmRhWUpBVlllQnYybmpaZldUQThw?=
 =?utf-8?B?UFJBNk41TGRoekVhdkhrWDgyV29yNFBrMzFWZDUwMlNqRDh1OERnQ2hjT3Zm?=
 =?utf-8?B?b3A0L3picjRtbXpUK3gwMmxMdzlpRjVEbXJtNzhBYWUwSVhNVm1NQlJMbHJ3?=
 =?utf-8?B?elRPUW1GRGplQml6QWh3dGM0LzVJdjBoVC9ubU9DdHhYdTRYaHV2UytoRUc0?=
 =?utf-8?B?cUtwRjFqdzJFK05NbThEanArK1ZvSHVxK3FSWE9LbnJicHpNYjZIMXl6MFJE?=
 =?utf-8?B?QW1rQ0hEZDR1UFR2RjFScTNjMXR2NVFJdGgrem5hKzNJYXg4NERpV1JEc0pi?=
 =?utf-8?B?eng1MnZWRzN0VzZZUElvRDRIem4rbVZEbjNiaWRHOTVZR21temgxdFJsbzQy?=
 =?utf-8?B?d1M4bE90Qm1XU2NSakZoM2dFMk1sL25mTnNwdTl1eWZ5eXROS2VrUVM2WE52?=
 =?utf-8?B?Y2NaaGtEY2RNMjNkYjVkUlpWc0JTQXFCRllIKzQ0d1lreE1oYmZGMXVURUhQ?=
 =?utf-8?B?WTZKSTlhL1NWMXhuTTBMUlZ0dHhLQVlLU3V3QnZYMTNIN214VC9ucVhvZWhu?=
 =?utf-8?B?ZVNJYnBWL1JQTWxWMzVWTVgxRUhkeUFJWTNDdWdHeWNlb0JvMkk0WXQxWjJs?=
 =?utf-8?B?V3RDbW9qRS9abnN0dE1Wd1NudXhGc21BaUhYQlVJMnh6enBZalVMSVA2eGFU?=
 =?utf-8?B?SytEMzRLOEFTUjBHaXJBREg5Vy95aU85UmxuUkNJK3lMTVJscVZzblJuZ3pM?=
 =?utf-8?B?WXFpb25DL2xQYjJ0N3BHN1N3NFVOTUZhU2tVZEdlSTZ0aS9kVXBQSU5ZWm5X?=
 =?utf-8?B?MHA0NEY1RVgvemhiZmhGbW9MbFBkdEQwYTQreFNFOTBUdHRtQllLR1dmdTdL?=
 =?utf-8?B?Uko2Z1dRcytaWFdRczk3RnBEMmU5U0hWenJ1STNVSWF2bFNmMS9sbnR2V0Ez?=
 =?utf-8?B?THdPbHJ2eGJEVkV2dnNsNEFKeFhrZUxnUWxDa2FYUlRIL29CRm15NFF6c0wr?=
 =?utf-8?B?S0EzbnFCYWJoMy9MMTRTeUFEbE9ZZkRGcTZqWVY3Smd2Vy96YkcwYU1QU1lQ?=
 =?utf-8?B?RGhteDZDTkRHUGtEZVhPZ3NzK1VtN2diR2lGMWowNHpFRTM1YUxBU3MrT2VV?=
 =?utf-8?B?SEhZNnVjWHVyU1QrbnE4WVdFZk5RTXNMKzdTQlFOQlB0M01Ka0wzcWhXdm1L?=
 =?utf-8?B?QldJNTVOTnY0NDVqUWhlRk5XZ0d6dzJpaVY3R1JaTWVFK3gwTWpMQTNsby9V?=
 =?utf-8?B?aVpleGpSU3FEYjVFRWNEakFmVTU3b2Jyb2lZZm9sQjhmUVlNUjh4SElnVndP?=
 =?utf-8?B?SlVsYTdNV2pUZ1pZY3l5YkxvcmxheGJCRmtKV2txN3VnUG1qTkJndVFFTnIz?=
 =?utf-8?B?SVZkNWRMZGF1a0lnSlRiNmtQRXQyeXlMOXVCVnFUWnVVNStyZ0FONEpSbStq?=
 =?utf-8?B?RmVMNHZPTGtPOStlUHNBem9hTEY3cEJuRVVHNDNvTEFJZHFLcytvOWJYeE1J?=
 =?utf-8?B?Qnk2ZjIwdmtaOURHMDlHN29aWEJRZ0FIb0xMbzJqY1E5dnVFM0NmTi9hVVpE?=
 =?utf-8?Q?q5wKAD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 14:59:34.7172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 585f6828-c992-4b16-0973-08ddea315473
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
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

Add a one-page TTM range manager for AMDGPU_PL_MMIO_REMAP via
amdgpu_ttm_init_on_chip(). This only registers the placement with TTM;
no BO is allocated in this patch.

The singleton 4K remap BO is created and freed in the following patch.

This split follows to separate heap bring-up from BO allocation.

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 42f97d568059..1a68ba17a62d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2021,6 +2021,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Initialize MMIO-remap pool (single page 4K) */
+	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
+	if (r) {
+		dev_err(adev->dev, "Failed initializing MMIO-remap heap.\n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
@@ -2083,6 +2090,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
@@ -2104,6 +2112,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	dev_info(adev->dev, "amdgpu: ttm finalized\n");
-- 
2.34.1

