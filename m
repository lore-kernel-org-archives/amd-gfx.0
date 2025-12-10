Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2FDD2CE17
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD36810E682;
	Wed, 10 Dec 2025 07:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5GHg+yEz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC8E10E680
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0Z6mgVQQpR8uMxCOcGYagYdi37uiAapgNWlS6nSwuEJ2O5zA1uaeZGg3tvuokGslZEWDW1txrxMSMOaS3R2M81Oe/3H44C8M64TGWvFWPQesrOuXDwYNllP2s/lD2WFDLW8pKKMPgJbhIIojH/1yCMrCgaUZkhLr19UnwIFymoVs4vhPJAhwGTSRhjLPLjRdsgXntwdfDcpO6zVJIC+NVmH3Yw6l19/nT9S/aspBuP5my/B4hGiJZMoC1U3b5tECos89vHqQ4SxCHrRguH9QCdSWjCI1IqGhtgm4uQFbozimE3uZnNfNPEAtGCuiIEGaMgoXUDHJa6ufYv1nHpRBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBlvtfH+iFevI9Vhud+cjqBC1RxlAJ5FAo/DjsfWV68=;
 b=nqVa1zjmdR6wTNOPteLwta3GetBjC+PXzF+/OTmOEFT3PKiHmC3qaTXvNmzWxrnhYEDVwkbjlqMo5x6Rr9pCLXPfhQDgIKwK8tzdRT70pmu4YZ+3FN6UrM8V7t9kRBer7qDzCmdGoEkLzx9NMOxATSgKfqhS0/MmCH5v0er7bUpX1nXGw1q/jS6FQWvAz7f1erAuokiotJmu9qW5iwvxJcKwqJVfhcGZvOGWFdB4eNDqKn8CW5yCWTsCpS8jeEPUWanCS1q7WGPfZ2K01NNDc/1sl6FfiNL8a1cch0lQ2z8vWBTGXt+eQXXd77Bib3G73OeUDaWbOF+tSb2U2nIONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBlvtfH+iFevI9Vhud+cjqBC1RxlAJ5FAo/DjsfWV68=;
 b=5GHg+yEz5/cz3i/uj6i+J48/L6egA1hFqz7wr2D/alr5P1YyvXK7elcdlKqRHN2PKoa8HfPqtqDP2LAMncrCX4HVqbYfWKORPXaHLIdrWQ5oudXA78ZHcGY2MTlgLwP1weUYwbotrpV1z/eNqZ6bE+xi6s0fJZJoBqk3EDXsCRw=
Received: from SA9PR13CA0048.namprd13.prod.outlook.com (2603:10b6:806:22::23)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Wed, 10 Dec
 2025 07:14:32 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::a4) by SA9PR13CA0048.outlook.office365.com
 (2603:10b6:806:22::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.6 via Frontend Transport; Wed,
 10 Dec 2025 07:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:32 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Update LDS, Scratch base for 57bit address
Date: Wed, 10 Dec 2025 02:14:01 -0500
Message-ID: <20251210071415.19983-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f877afe-09f5-4381-305b-08de37bbc443
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YKCWoPHw1EDS/xQsXhJCIzNgR2J5VG9QDn9YXxS4xXrfV2z6OAgJvjHOdYqr?=
 =?us-ascii?Q?KHu4EkItQVbL07cPUaMgQHhyjJkQ/VvEssi6NsXZV7McLWQ9AmQbpdDsHxu3?=
 =?us-ascii?Q?gXQhQCv03hSh932hEWMDr/jgNpqCbhN/VZ5FQ5NrN6TAYi5a8AwuLF0c3kCl?=
 =?us-ascii?Q?vS71BlMfgxDiOJuslCuVf8ezspuvSCQhJvTDrJPIC+SBEGWpW8sN2jvPx63W?=
 =?us-ascii?Q?9pTNEomqNHDY6pQpNii4yUQSdMA2ZJjsv57cxZO4ds8qu8b6IdkuNdu9Qcmr?=
 =?us-ascii?Q?drziNFNK/vcK9s+x2bwPC+SnCoaQrqHBNRTJzWmaCFjYkriGVvr1mZKQKKIb?=
 =?us-ascii?Q?/pS3YfHB6Jc9c8i6vJd7InJHQ8A07H8AlQKyVrfaKjZf23PISOr2ZgSBAGdR?=
 =?us-ascii?Q?uMFpieq+QjklNN1BfCQcEwlFQk2ygaRQzxg/TbOqLTIXx8nzHUyCgpUVC4w7?=
 =?us-ascii?Q?NseR20HO201PU721AKM9zRj2UyqfXopHmfZbwfoJYLfo9HdyuWUKDdFt1Fnb?=
 =?us-ascii?Q?Xx9fHkkptKPhW2Pa1XbCO+xGjM95yNVNQO5UkeHUw32m/uQ9mFZDEFCpNZn2?=
 =?us-ascii?Q?fpdTxlw7K/xzs8l5IC21pbhT+1u3vPsq4IHYcPeLCOnOA5mfBPOBnUe0rnpB?=
 =?us-ascii?Q?aQ8O9YzxHdKNDOhW4G8wZnViLe0sroD7qY9FUShE7bB4x3z9Mmuc9YXPI6sX?=
 =?us-ascii?Q?MK54Ywh0tBKQSXtvsLtNRPQYnNEJ+3ELqpZLEbIU84ElwazS8XGjbkZSKbZn?=
 =?us-ascii?Q?QhFv9DEKKFDaRupAzpTGRU16AB2+e5cOHGyY2omMuzEyhi9iH3Irc6BWgcy8?=
 =?us-ascii?Q?xovoOBIV1WIlvX1IQ27e9HRxR1J6iki0Z6H4uAHz7UMvGrHYrVlB/IUCkM61?=
 =?us-ascii?Q?WT0azyE1oKR/CPAGgcCSMOnZmvj7nlgYCQyhBgZDVpWh3thQ21nVWhTk2O9R?=
 =?us-ascii?Q?XXRt8kuVfCJy6FNWyNKCj/61VWdunTbS7VF41mSjcqLjw8YpuBtcE93U2ksD?=
 =?us-ascii?Q?4Xrk+UEu/Iin+lmPD64qdV3M8I1S7CtUGFwJuzjIFMGU+wGrCtTDDct5ZUMG?=
 =?us-ascii?Q?ZV//qWSsEIZuY1OBoZvwL6CYCXuZvVAyEY+5KQAHeMreca3gSEtQd7Tq3ai1?=
 =?us-ascii?Q?C65+BxNKru5n3rGYN1kaqiGwYEDQe16Lqtr1jY5eH4nHrG/rNMCH8hhfZVmL?=
 =?us-ascii?Q?9e4PMDQ81KbgHK6l6C0WCB2r1QGCqGlwmelmmEafH1eWn1j4P96AjGLyvWnN?=
 =?us-ascii?Q?in4sOITFvoPl7oD8WAdEiVckE3YMydAsXaFtOv7w9okWnc41UvUcQx17VZJR?=
 =?us-ascii?Q?6I+O/wgwlJZRpdpymxNsQ8B0lnuX9l2smcH2f98gOOXEtimkanoixVQJuUbH?=
 =?us-ascii?Q?To4ucl1xE/X6G65CoSPhn9/FnS34Q599i0kkDO3a3bGFSGphErOgn06Cltpl?=
 =?us-ascii?Q?WQ+ErhN5Z7zTQAIh2TzajB0Qv57aEBeYt8zgUVkxON+gIVZGicKlQM24F9//?=
 =?us-ascii?Q?ZejKy0h9faeqSnRude1n7XkBxl6nZiJz+9JdrJ0f962LFO1LESGKA/wXU99o?=
 =?us-ascii?Q?t9CfXxQpIq5VxG34Lf0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:32.4036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f877afe-09f5-4381-305b-08de37bbc443
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

From: Philip Yang <Philip.Yang@amd.com>

For 5-level page tables, update compute vmid sh_mem_base LDS aperture
and Scratch aperture base address to above 57-bit, use the same setting
from gfx vmid, we can remove the duplicate macro.

Update queue pdd lds_base and scratch_base to the same value as
sh_mem_base setting. Then application get process apertures return the
correct value to access LDS and Scratch memory for 57bit address 5-level
page tables. This may pass to MES in future when mapping queue.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Acked-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c       | 14 ++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 10 ++++++++--
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index c7f331f74b9b8..61ffba9a252bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1362,9 +1362,6 @@ static void gfx_v12_1_setup_rb(struct amdgpu_device *adev)
 	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
 }
 
-#define LDS_APP_BASE           0x2000
-#define SCRATCH_APP_BASE       0x4
-
 static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 					    int xcc_id)
 {
@@ -1374,12 +1371,13 @@ static void gfx_v12_1_xcc_init_compute_vmid(struct amdgpu_device *adev,
 
 	/*
 	 * Configure apertures:
-	 * LDS:         0x60000000'00000000 - 0x60000001'00000000 (4GB)
-	 * Scratch:     0x60000001'00000000 - 0x60000002'00000000 (4GB)
-	 * GPUVM:       0x60010000'00000000 - 0x60020000'00000000 (1TB)
+	 * LDS:         0x20000000'00000000 - 0x20000001'00000000 (4GB)
+	 * Scratch:     0x10000000'00000000 - 0x10000001'00000000 (4GB)
 	 */
-	sh_mem_bases = (LDS_APP_BASE << SH_MEM_BASES__SHARED_BASE__SHIFT) |
-			(SCRATCH_APP_BASE << SH_MEM_BASES__PRIVATE_BASE__SHIFT);
+	sh_mem_bases = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE,
+				     (adev->gmc.private_aperture_start >> 58));
+	sh_mem_bases = REG_SET_FIELD(sh_mem_bases, SH_MEM_BASES, SHARED_BASE,
+				     (adev->gmc.shared_aperture_start >> 48));
 
 	mutex_lock(&adev->srbm_mutex);
 	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 1d170dc50df33..557a5ade329ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -342,14 +342,20 @@ static void kfd_init_apertures_vi(struct kfd_process_device *pdd, uint8_t id)
 
 static void kfd_init_apertures_v9(struct kfd_process_device *pdd, uint8_t id)
 {
-	pdd->lds_base = MAKE_LDS_APP_BASE_V9();
+	if (pdd->dev->adev->vm_manager.root_level == AMDGPU_VM_PDB3)
+		pdd->lds_base = pdd->dev->adev->gmc.shared_aperture_start;
+	else
+		pdd->lds_base = MAKE_LDS_APP_BASE_V9();
 	pdd->lds_limit = MAKE_LDS_APP_LIMIT(pdd->lds_base);
 
 	pdd->gpuvm_base = AMDGPU_VA_RESERVED_BOTTOM;
 	pdd->gpuvm_limit =
 		pdd->dev->kfd->shared_resources.gpuvm_size - 1;
 
-	pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
+	if (pdd->dev->adev->vm_manager.root_level == AMDGPU_VM_PDB3)
+		pdd->scratch_base = pdd->dev->adev->gmc.private_aperture_start;
+	else
+		pdd->scratch_base = MAKE_SCRATCH_APP_BASE_V9();
 	pdd->scratch_limit = MAKE_SCRATCH_APP_LIMIT(pdd->scratch_base);
 
 	/*
-- 
2.52.0

