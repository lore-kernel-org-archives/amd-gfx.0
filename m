Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83556CA0EFA
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0220110E1B9;
	Sat, 23 Aug 2025 07:20:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aBaAzQzd";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B0110E1BD
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6hc7ipwtKvqgi9SXVhT5MC43K9oempB/S0LNKtSGHLVl/WPyb8B1WCKLNAVujiCK4ZFJZa1xOKllw67v4Y6CPD3Hp7xCBBCHSqZ0wadPOPm1gHqv1ncx8W7kL0zEoawj242pynPRy9253j5Rr1F/D/Nu220Rf7j3Zs8RMuTufoWT5ItXyS+vsfBy0HOTkmVLlhETPfRCcK9zE7ZonRCAOWURqVE0bviUVruClsjqRWSPIBXXwobsXvMOiLOqY2+mxkx6E+MdcraRfNilDx5agCcPmqgLBsoQ+fn0R4LBbitZEToVWNv8Kv1rccvkKcbH5qIPBiLY1SReKrOaMmP4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RS6E6eDRovtvvyQaleRTONC/KeH4m+yM8I1ZoKe5AWI=;
 b=pZpaodE9XWgMHkOIrG36+Jdapp/gV1o7Nbr4Xr1ym4mE48bQiSy8QiD9wX0EgDNkI5m4oZ+8oXzbd7apnQ3v0/6QQafhI2JKwFRf4upUZqxzkqNvmUxu9PnY1BssigvBjFpNEK40Bz9R1I1iOpa3fArUMqiH+9oyRoyG1RCJHfMnXO+yojKHPSc8XgKJ2jeO/IGETaP7WMFTw5DDyDGLR8r5MnbMt4IArtnzZFdTA0bvR9fV2yw7G5+S7DkF7sIinLvRCmyM6XDPrTVmTWql8HUs5hhOZvsWK+atiZTkprxFUZqMbNaHUR6kz0VBoEOGZp26waY6jcXVEOLJ347Xsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RS6E6eDRovtvvyQaleRTONC/KeH4m+yM8I1ZoKe5AWI=;
 b=aBaAzQzd69D/Xhmlwp45io7kiD5LuD42NM77Kpi/fV4Zm0o4XKKAuUqvwjMHZ1If+GpgFU6z4U4etrO2yd80oy4f93vUQ3HigWoTWEbEMQN58YbpSFLz2iKgwx9REjTurp2W8Phm6PQxy3nEfrKtowDuSzCiVTW3JsAUT/+q/88=
Received: from SA1PR04CA0001.namprd04.prod.outlook.com (2603:10b6:806:2ce::8)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Sat, 23 Aug
 2025 07:20:45 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::4c) by SA1PR04CA0001.outlook.office365.com
 (2603:10b6:806:2ce::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 07:20:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:44 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 6/8] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP
 Heap
Date: Sat, 23 Aug 2025 12:50:14 +0530
Message-ID: <20250823072016.1272328-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: fef16d69-0971-4911-b59f-08dde215932b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDZPeVF2N0dqY0t0alYxbXlOdWtVZ2hwMU9NaUN3UlMvOXJ3VGRaYmhuRDdR?=
 =?utf-8?B?VXlUZlFjbTJEeXIvaXBpZ3J6Qjc3QnJaSTdjdDRFSzZSOElTZjB1blhyalE4?=
 =?utf-8?B?STNDWDNyWDN3dEtFZUNIVHdseEw1QloxM3hlbkFoM2RaZ0JZK3NRMStjRHA5?=
 =?utf-8?B?aXZTcUFiVm9RcmRwZHQwd2taQzNwaWFGZjBpN3pOWUc3cTlkOXZkOXhyK2tr?=
 =?utf-8?B?dnNhMXdGK296RG1NN0U2NGk2dEZhOFlLaUc5Y2RiOWFkOXA2bWRwbncwTjV2?=
 =?utf-8?B?NjFmM20rYWhHVmJ2QkgvSG1kM3dlKzY3Yk9qY0p1THBPQ3IwQnpPVkk1c3RQ?=
 =?utf-8?B?bFliallIWlMzVnA0VFZZRU51ODBPamdzTStDQXhBdWFFa2d0YVFsS1dlS3Zh?=
 =?utf-8?B?UDBsSHFJVnFNbkxpNEo0K0N6ODdMbk9jYjFhY21qL0EwRmRoWUVUbERHQ294?=
 =?utf-8?B?UUxpc1FYWDRxbVJ5eFI5RzlRdDEzNCtCODI5ci9qSUVXaG1qK1l5cTZjTWZj?=
 =?utf-8?B?OW0zQnNoamNjaDExLzhrbjlwWWtOUFBBRlhHYUl6K3hJTGRWSTFPOWJrVDFR?=
 =?utf-8?B?MWFBbmp3RTVtQ0xXQkNwVHp2T1FwdHZEajJZUURqNVNqaWVQUkhGYndVVEty?=
 =?utf-8?B?Z2VqdTFoMW93eXZWTFZ5U21jQkYyLzl3Z2xQY3ZQS0tiNXhpak5iSzlTR3k1?=
 =?utf-8?B?Y0xNUjJjWHJOU1VsRys5S0M4R01LTTlWUzdSeVZoVHZteksyNWVaalpQd2Jr?=
 =?utf-8?B?ZDRpb2sxdXBpSk1nbk9kZkJMNzI0dE8yRmNTQ2xuMFRhM2wvK3prMDM3MmxY?=
 =?utf-8?B?bjg2R3RhbDlseUtLR2VVZkVYNjRDa09qb2dVdGhpS3hyOUNoYk95N01YWkZV?=
 =?utf-8?B?SjFuWXJwNS9ndit6d0VRMW1ORlNUYkZNVGRkRVF4K20yMktxY0RRcmZrdVk4?=
 =?utf-8?B?TlFIQlZpSkpqSmlTdWRPTDlaSWwxV0JoYSs3TnhYVVRYSnF1SkFiVFVMTDIx?=
 =?utf-8?B?QzNmeHRURW5LZ0RKWXhFVUlOK0UvK1VLYWNUcCtxRzVQTFBPSmpNWjg0UzJP?=
 =?utf-8?B?WHZhanlhdTVRNWY5eXVFSkYwTkloU1Y0RDVVQU52cGFLYk9RZDZ0LzNtSldR?=
 =?utf-8?B?UGRkcDFlOXRCVWM4WHFIVWVYQzdFSGtYN2FoMSsvaFJWMGd1cWV0QXh3YnVU?=
 =?utf-8?B?SW10ZFJJNW9VUHJTTFo3cE1nTnoyN3EwVHFWUnYxWVJ3bklRclJ0TC8wSlE4?=
 =?utf-8?B?b3lnbUVUY1RCS0J1U1RwVjZLK3BWRmd4SzZKMGZmdno2WTRGNWd0Vk5WanE2?=
 =?utf-8?B?Y2Z6SENOeG43NjcrR3g0T0h4WjFIV0ZxMFJrTUVyU3dCNDByNE9yL0ExOG4r?=
 =?utf-8?B?U2RST1NWdWp1U3V5WjJ6amM0NlI2enVYZVdHdE42enRzengyWFQ5MCtzMUNZ?=
 =?utf-8?B?NFlHRGhhWFdFTVhIMkZUUmNqOGVMaDlXMHhtc1ducFhiWUdPVVNIUCtNK2RO?=
 =?utf-8?B?TTJ0dGZmaTJyd0JyOXViTGZnZG1mdWN1M2xxcHFJWGVGTGtmODlhRk5HRnlG?=
 =?utf-8?B?c05jb3RNNzBoUCt1R1JYd1FNcjk1WUhDUkhENkpuZlQwalRMTXZmdVg0c0dp?=
 =?utf-8?B?RXFpK3Q3cDhoRGlaYllIUXZib3J3eUxIcWIwUk9jTFRJeU15ckpqdTU2OWJx?=
 =?utf-8?B?eEJsZXNZK2dWbHFZYW15NzArTnBLOTIzUWtwdzlTVHJ3V0ZtYVpjQzlQKzdT?=
 =?utf-8?B?MDlFWHdmekxxVjJZTXlDSXFwYnZHMDYwcEdyV1k3RSs3WDBMUjhxL3VpOGRw?=
 =?utf-8?B?eHdqY2FIZnd1bitsNm9VcnQ1UnBxZktDZ3VxcTNXTDlqMjJxNSsxelNQVDVt?=
 =?utf-8?B?Y1dYUHVOakZNUnhJeVlSV3FvNGh6ai9yZTJkQWdoQXp3NXR1VE9aK0tVNWo5?=
 =?utf-8?B?cEtTaHdBMkx3VnJnbjhCVndvNHZIVDR5L1FoQ2dyTHhGeXZvVWpEUVJ1OGtw?=
 =?utf-8?B?QjR3S3c2RWIwU1ZaZFRySGRGQ3JCTkprdzdacjlTTVJSdmkvYXBtc0w4RnQ0?=
 =?utf-8?Q?yZko05?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:44.7138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef16d69-0971-4911-b59f-08dde215932b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
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
index f6027ccd9196..58b6ab1be4c1 100644
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

