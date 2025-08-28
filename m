Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A0CCA0FFC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F6C10E93F;
	Thu, 28 Aug 2025 09:15:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DUnrcXys";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C45510E8AE
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGvOTZrlnIm4zelbz4brVYJbdc5EAJhTpBVH6FjuioBP4ylicAebZnimZYJwWrgnFwitGIND9snuMu8mqxM2A/ayzcvOMjgmjhe/6uyysHRSWNAUJa4DllG8PeWA4it/e7W/lR1mylS1T4v2NBZDRpfyoQvsy5i1fqJ26aMmXeehWnimvxFvO/3pKr+hRmVRrymN6cP1ybQ9YccMEkZzAtRzjZFVEi4zhYs3Xloz6kl6Dz8FfAv705D+KuWCEhNNCjr4jVEzfc8Rv/sEEvAGZbZH40l4rW3NNkx647GVuf54MdLyk/bAy1+gFZtsSFEWlCLkRmlHLjZbbefKw7uIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HgSfy1skhkgD1/iXYbPFJPrETgbNK2EKC2qgj80XxE=;
 b=ZzE//pVToSiqRsJvdLi3+2k6GKICLFTKmYobt5xEphHBZtdWYplzGM7iCp6FiEWoqb/PzUHGHWCMh0dlcU7eWCpQGCnqdx6nTTZyGjisRaBoyd6dDb5INdb+JPc2sSqJnGvTClmSI0gZmEjKA0dESUIELxh8sKV9I55cceaUQDoLMePjM96rhpPIQMDBs/dmpnUuZdjPq2ldOH2T3dRXI2BABuRY4SX/+LpDo8UzniOCVtaAD9ynmvQhlOT+AfCnsf1a2T58fGmJ9b2vARtMWTKMENL+Vb+DZ55YXSNr6KNJugxT8OrOBjudlXLbyetZOKwdOkMdYt/VmVrICJ25HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HgSfy1skhkgD1/iXYbPFJPrETgbNK2EKC2qgj80XxE=;
 b=DUnrcXysuxgLrUkDdhYmKI62xUthtD10FO3LorKmtPjoOITt9XuZlYosNHj+nM07OOc1pgrC3OVQbsS2aRHsRxDm+ysOJllJ1mKiFwsHn5yK/UYG8JTitThKZgRPpzf10cN0x+HgZSP7kGoa26AGlsJ7P3ob/tMD+42raRZrPME=
Received: from CH2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:610:4c::18)
 by SA1PR12MB9245.namprd12.prod.outlook.com (2603:10b6:806:3a7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 28 Aug
 2025 09:15:37 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::49) by CH2PR10CA0008.outlook.office365.com
 (2603:10b6:610:4c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.16 via Frontend Transport; Thu,
 28 Aug 2025 09:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 28 Aug 2025 09:15:36 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Aug 2025 01:46:03 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 7/9] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
Date: Thu, 28 Aug 2025 12:15:28 +0530
Message-ID: <20250828064530.3948378-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
References: <20250828064530.3948378-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|SA1PR12MB9245:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d0bcd22-158c-4016-19b3-08dde6137323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEkvL0NpcFNHR2xqRURyTkVpb0IxSGtpcnoxbnNIYjVubXpISFhvMHNNT2Jq?=
 =?utf-8?B?ZmNGSTRmOUxmYmtoekJTUHlxS0VWSFgySnFiR05JUUJ3bVhvV2R6UlM0SFUv?=
 =?utf-8?B?RVRtVm5hUW5FblJhR2ZjS2k0ZGdoTUY0ZU5QamNwTlgzZmQzc05QaTQrUGVR?=
 =?utf-8?B?SmtuV0x2d1puMDdPMi92d3J4cFBPL0RjUUhPMTZrdmJtRk1MaEgyV1VVQmNI?=
 =?utf-8?B?WnpPUXFCZGU1dGZoNS82ZEdOaEpUa3NzK1oxQnBMY2pSemtjdVByb09aeStj?=
 =?utf-8?B?Vk92YXpta0hReUFSZE5yZ0s4bTdNeVVhL29VOWZoME0xZjNzNjhHZWJOK2E2?=
 =?utf-8?B?YjJzSE9qS2VMQWhKUkc2SmFzbUxBcGdwRzlFYjRmdHh1VTFQTW9WSUFQWDdZ?=
 =?utf-8?B?Z2V6K3ZOckF0TngxUFpVa2dqYnNzZ09WTWVwN2wwdmNKWFZGNS9IRFYxdmxl?=
 =?utf-8?B?U3owODVodEwxMHpSL2VyNUVYcDRBYWdSUXhMK1FRVGcrMHFrSVpNUk1nM3pZ?=
 =?utf-8?B?bVExN29RS1dYaUYrTTRIenlnaWNIRGRiUml0NnFMd1hCSmloWWEyb0h6Z1Fa?=
 =?utf-8?B?THN3UU9FUFF5VTRUSG02QnJOWG1tVTVUa1pVeVRJUGlIUWM2VEhxOEJrdUp2?=
 =?utf-8?B?eEEvcGlwbW5vZUxXZkdNUUVjOGsvSnNoZmtQelFDWHhVdU55by9Oc0pKSWo1?=
 =?utf-8?B?WGc1WDY3NjlSVTJuL2crWTZicEdsa3V5RmZmQW1VdjdLT0VNbnNGMjlSb2kr?=
 =?utf-8?B?cW05S0JvOGcwcDlZelJIdjNWN2FkbW1DYzJnOUpGUG95WjNEeDRxNjNFc1hK?=
 =?utf-8?B?TUZhYXEwWFJKYkNvckZxc0p4S2lzUlY5bUNKUEpWOEtSVExTOStWUTlSM1o2?=
 =?utf-8?B?ZFlRWE9KSHNJekZoMXdLUms1SmJodnFjUTErTnBLdU9UWnVkVnNiVWFkVE9j?=
 =?utf-8?B?TTVacFJSd2IxNzlKak1TNW5Nd04vaEpsSGdpcUxIeEJ5SVZUdERBczVNdzBn?=
 =?utf-8?B?VE9vQmsvaEJMS1FxOCtkNzZmYmZGZXVsQ2RDQmFtOHQrU3dERGU3QUtMb1Bh?=
 =?utf-8?B?ZUpWTUxHekR2c2J4S0hGQUUvbFMwRjFSaXAzamdBSzJtcU1xNlZ4TVdPVWk4?=
 =?utf-8?B?WG5uNmFBUXdFeHBpMDFhMGFHYVRLclJ0RzYwaks2ZmZhcmIxVm9HNDFXbFpC?=
 =?utf-8?B?dHVTNnRsT3I0MzdwNGZRKytnclRidkFDTjl3TU1ZTnBWMG41emNmQnQyTHFy?=
 =?utf-8?B?eklPTEN4UTVCN0NEV1hGczRuY2VnMzBoYkN4ZTZNd21ndGxzTDdWRnF2WXVO?=
 =?utf-8?B?UmlOQWJiSU92Nm9sT25jWWxYMEdnNDJjNHJ6ZitSZFE4S0JhYm94U0JZUnBF?=
 =?utf-8?B?eEhMelpsSGw2VlIwL2l2alljU1ZDcE95ZkdERk1NZk9kUFMwRkVEWWEyWVFF?=
 =?utf-8?B?RHY5Qk1ad0pHNGNPY3REMVVod2NnWHBuc244cFBBVldZWnd6Qm5wVUVwZHA1?=
 =?utf-8?B?aVl5bG5rbzhYWVBXOWJLakQyUzdzaDAyTWQ3OEI1OGxEYmVZcHpnNTB4Ykx3?=
 =?utf-8?B?bFRRVy9WQzZKRDFHajh5ckh2alRacVFaYXZtZjhadkJSSE4zTjVEN2RiWTRy?=
 =?utf-8?B?VGpsaitFdHlLSWRONEY0cldxb1hCc0VwalJ5Z2krNFdTTzFqZUU2SUV5UzFx?=
 =?utf-8?B?VnRibXMrRkJUS0R3U1Z5OHFGdGp1dGdIOWdpTzI3bEJRVWNoMEx4ZGVqa1FT?=
 =?utf-8?B?SVJhS2NmajRwT29HWG5adHRLYjdWMDlPSXgwOVpsMzFYNkhjU085K2VhSzRw?=
 =?utf-8?B?dTBGNlVrR3lxY0d4YjZFV3h5eWY2akc3TjZ1VGx4a2NVNUVENmRPZ2txb1FL?=
 =?utf-8?B?RXRmVmxJdXRxZk03bGZPcDRKYXFzQllEME84NkVKQnFmTFQ5SjFoYkxnazhG?=
 =?utf-8?B?MlBtQ3Y1Q3lRNGh1dlB1WlMzaUVUdEN4aGJzYnR1NGV6T20vR2ZhMC9NQ01m?=
 =?utf-8?B?Q3lScmx4Wkx4TEVTTzJ2Z2pYekQ3MlVkbk9oUG8yaE05ZE5XZjdJajNhQWdi?=
 =?utf-8?Q?x9Ree/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:36.6363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d0bcd22-158c-4016-19b3-08dde6137323
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9245
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9211d250fcfb..7822d8969c9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2020,6 +2020,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
@@ -2082,6 +2089,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
@@ -2103,6 +2111,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	dev_info(adev->dev, "amdgpu: ttm finalized\n");
-- 
2.34.1

