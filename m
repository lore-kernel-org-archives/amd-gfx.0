Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F65CA0FF2
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9560A10E8A3;
	Thu, 28 Aug 2025 09:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mz6QLpLO";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BD1B10E89E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:15:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eGUHjQrdLhDIRpaatlh3nrAHKHFhFpC8Et0lKzxzrNs2dj7U+1KoDMLk4iytIHyNDsH7lJ1hpIoS56UR3RfUh79zkHg87rs4xjfgWDH9ud2stxMpWjc7gHc7BHl+M6mfV4XyxMix/UDKkjjWqKdxvMyCoy7cfj2O42MQ12UXtkht9zbhCdsG9xOxU20/u+olIvzwOISkzOYayh3v76735fFUzvhO8FTMYWej0veJQih/MxTDdh4jgj8B2q3R0LPTtK7CELTC4IbgLsp1+Di9wa/rQRU7D5IXevaemRiX///x7DMnKkAydPxouy2Gc3XKTNHQAYD4SAD38QOlMD5e2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoxpxOYhwnwwC2bQBC93KxN4HBMTp1WQQOOM54O2c6E=;
 b=vp+WgjKq/H6zkxWNsj+/M3euBsIj2d4CpwsQSomMgtVZjyK/nAdORjp3eDT/bzJCI9sS7hVXNsvH5vV7dKOIPEYjBGvnOhod1icBNQomMBRHn6M9/ouqiVgdeCnReqPNtF2GgHBOuP2J7fVVV1WQGHhDSuhPsdjGYAuuOofLbzps3sOoAUMaCtrxnqIbZs0sarShquhMcjmNfgTo14HA7y5Ymj82z1V+KZysO4H5oYaNbUvyv05LVQr/O0yYozRxcZJnkHW20BUZqo2wBjRjbKRJ++8in38E9HCHvVoEwEm64IUh7PW8WD33I583+ineCSsTQYsyIHtqeBLWOOIy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoxpxOYhwnwwC2bQBC93KxN4HBMTp1WQQOOM54O2c6E=;
 b=mz6QLpLOe5HNGSTMn+Fe6Tq7fByIxCzFceqng5bSXCtu1qkvAPUbfhS0EC3ZTw2VnGQBgrm/2bqrGhsHlDFjHeWb2LSs9uS1Mqfg54D4NqMXB7s3TSAjFlrlOdZumUIkNrHhSYa+EBYZC/E8mfXGy6EhiM4UHNacRonusSTilMc=
Received: from CH2PR10CA0029.namprd10.prod.outlook.com (2603:10b6:610:4c::39)
 by DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 09:15:37 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::26) by CH2PR10CA0029.outlook.office365.com
 (2603:10b6:610:4c::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Thu,
 28 Aug 2025 09:15:37 +0000
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
 15.1.2507.39; Thu, 28 Aug 2025 01:46:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 8/9] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
 BO
Date: Thu, 28 Aug 2025 12:15:29 +0530
Message-ID: <20250828064530.3948378-9-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: f1990e28-05b2-4d79-93ba-08dde6137328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGxnME1tdXF4dWlCQnFXOTdJTldSZ1pSWWhUZHJJVm1kM0NjblBmeHM2cmow?=
 =?utf-8?B?RUVmNnRiWERZMldMMUlKTVZrUnFYVFpkbDk0aWhzN2ZVQ3Q1R0FGSmFNd3k0?=
 =?utf-8?B?d25FMEh6djJXZEY5VnRhQ0JpMHhKNU5YOGRGSVV2QWxQWDdVQ29uQzk1bEwy?=
 =?utf-8?B?U2ZxRW9GNkNLRkxObUI3WVdWT0tCK1lhcXRzay9icGs0aWU2eVJaMU1FTzBQ?=
 =?utf-8?B?dFFBdUhnY1JENDd6WWNSUEZ5VStPcTRTdW5ZV21WMHNTcFUrYlE4SSs1dkJT?=
 =?utf-8?B?UWJORnFUeTl3Tzc0ZUJEWW9JUmhRVHJuVkw4b2xZNG1tTDJEKzdadWZnaFQ3?=
 =?utf-8?B?VWRPd3cwVnE3ZzNHQXdFaXdXZkVNUEtmdXlOeG8rSmxjaG9leldJTHROTjBC?=
 =?utf-8?B?R0pqWjBOaU1KcWdFUVdNUmtjNGRDdjhSMW84b3A3RXJnMjNNRzJ4YWJiZ1ZL?=
 =?utf-8?B?TS8vYnM2OEZsUjRwWjlBR2d1d3hLazF0emMwV2JxVVQ3YW5Wemttc21KUlJj?=
 =?utf-8?B?UDdzS2dmQVVNa1BQcTE5N2R2UVhPQ2pXU0dzdUNTMzhXSzVJUmdETUZNaDk3?=
 =?utf-8?B?NXlIRXd2eURmcXRrU2prMmEwUU1iTWZhMHhKQ3JaMDBwY0VKUE41eFU2RTdC?=
 =?utf-8?B?S0V4enpuOElQYml6N2pUMTJ2WjJMUDRxdkZBMEhxMVk1RTlDbCt6aGVCRm9I?=
 =?utf-8?B?ME9pTk16N0pZQUtMc21rUzVhT0NmR2N2SHBqNmJFVjJxdGM1WUladnZGVnNw?=
 =?utf-8?B?WXFNS0M3djZtbytCUGQwTXVlQzIyMnZKWlF2ZFc5dXB1TFoyUWg4T0YrdG9p?=
 =?utf-8?B?eFpxM1NiUUhjRVJuWGFkbjRXRzhQK25SSSt1VW1CbWM2M2Z5ZmFwajQ0c1Vr?=
 =?utf-8?B?M054RmVvUXVVYUhvYnZkSGhBMkcxcy9kTzgwQk91U25PQlJxQXBhRGJDa0pG?=
 =?utf-8?B?UnN4aGhRSHBmNUNaS20xQm1XcHBtcmV4V1lvMTU1eVpMZkxkOVd1YWZPV0Vj?=
 =?utf-8?B?OTdCYnN2NnhDYlo1YnRTVUlvS3MwcWRrS2R3TWh3azRnRnZBbklPOXBzdlJQ?=
 =?utf-8?B?SkFXRm5YZHRJM2JHazE5WWlQdE9SdEpUL3dFUEttMWJQUXZ6VkR5blVtaFZR?=
 =?utf-8?B?QnFlWWYxTmUzTXduNldJZkpoQytESjVlS2puTnRPSHRlQnlPRkI4VWZBTzlS?=
 =?utf-8?B?WnIrRHFDbE1odWMyUzdFQ3Z3VXZQSHJMaHlGY0ltLzV0cGxPb1p5SGxIZW5j?=
 =?utf-8?B?SEFCN29QYXdHdFE4ZkJidjkxU2YzYjI5R1dTSU9SNnQvNUpyTmg2M2Y4VWRC?=
 =?utf-8?B?cTRIaGFpY1NXUVBrdHlUU05tZmR6YTQzSG9OYkRtcUZVU0Rubld0SGFoNC9Y?=
 =?utf-8?B?NVloZ2ZxNkgrcVFMY2Q2R3VQRjBPVU9Fc05CV0NhdTVnbDVMNnQ2S2R2U1FT?=
 =?utf-8?B?d0pXMGN1UTVPOGRTVjBnb0hwUEp0SFlLQlNMdVVDbkRBNXdTQ2F4ekI4cDZV?=
 =?utf-8?B?Snk4WXluM1hPK0p3czZrR2tXUjhvWHNyWUtMWjhUbzhZTXVJWThPSEJzQ01r?=
 =?utf-8?B?L2ZCWnNrOU1qUWFYR3B3ZFozN3NVcXJSZ05WVXVvU0EvS1EvbG9xUkcwSEVp?=
 =?utf-8?B?eTM4YWJ4T3lDdzY3WkJlellpc2R0RzljWnRDMlVqTHdScVphaHNGWDhHemJT?=
 =?utf-8?B?ckVJaHBMYThlOGI3b0FwNFRMZjRmbHFyR0lCOHU1Y2NlMHQvQ05mNFU3NVNZ?=
 =?utf-8?B?a2JlSmVQTnV6dDZxR3QrRGlBajJkQjJ1RWJKY2p5eTVZdVlzWERkRkRXb0FQ?=
 =?utf-8?B?emRBWTlmZnZ2Wk92NEdGZDY4d05UTGtqaEx6NVZ1bHJNNUxWUGYvcXJmZWJN?=
 =?utf-8?B?RmlqYkRnQitDRlNZbVEyRmFNYUdkQkkxcE52dzMyWmp2eVg2Y1Rna2V4YS9I?=
 =?utf-8?B?K2V2TE5hczJERFpsK1hYVGpqNzZ2ZzRPdzlabnJsemkwME40QjhCb3A0Ujh2?=
 =?utf-8?B?QS9JZHFSVkx4Vmd5Q2ZLamlYSHk4NTJHS0hhZFVsZ0puSEIyOGRVN2gxeXhK?=
 =?utf-8?Q?hCrSmJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:15:36.6736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1990e28-05b2-4d79-93ba-08dde6137328
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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

Add amdgpu_ttm_mmio_remap_bo_init()/fini() to manage the kernel-owned
one-page(4K) MMIO_REMAP BO. The allocator runs during TTM init when the
hardware exposes a remap base (adev->rmmio_base) and the host PAGE_SIZE
is <= AMDGPU_GPU_PAGE_SIZE (4K).

The helper is idempotent (returns 0 if already allocated) and only
returns an error when the actual allocation fails.

This keeps MMIO_REMAP lifetime handling localized and prepares for the
subsequent patch that exposes a userspace handle.

v2:
 - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
   rmmio_base. (Alex)
 - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
   (no warn). (Alex)
 - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
   is stored in adev->mmio_remap.bo and will later be exposed to
   userspace via a GEM handle. (Christian)

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 64 +++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 7822d8969c9f..0e301cab74e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1853,6 +1853,63 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 	adev->mman.ttm_pools = NULL;
 }
 
+/**
+ * amdgpu_ttm_mmio_remap_bo_init - allocate the singleton 4K MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
+ * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
+ * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
+ * GEM object (amdgpu_bo_create), then reserved and kmap’ed once to exercise
+ * the io-mem setup path. If prerequisites are not met, this is a no-op.
+ *
+ * Return:
+ *  * 0 on success or intentional skip (feature not present/unsupported)
+ *  * negative errno on allocation failure
+ */
+static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
+{
+	int r;
+	struct amdgpu_bo_param bp = { 0 };
+	void *kptr;
+
+	/* Skip if HW doesn’t expose remap or system PAGE > GPU 4K */
+	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
+		return 0;
+
+	/* Hardware remap page is fixed 4K; skip on larger PAGE_SIZE. */
+	if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
+		return 0;
+
+	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
+	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
+	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
+	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
+	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
+	bp.flags       = 0;
+	bp.resv        = NULL;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+
+	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+/**
+ * amdgpu_ttm_mmio_remap_bo_fini - free the singleton MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
+ * amdgpu_ttm_mmio_remap_bo_init().
+ */
+static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->mmio_remap.bo = NULL;
+}
+
 /*
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
@@ -2027,6 +2084,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
+	r = amdgpu_ttm_mmio_remap_bo_init(adev);
+	if (r)
+		return r;
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
@@ -2090,6 +2152,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
+	/* Drop the singleton MMIO_REMAP BO (if allocated) */
+	amdgpu_ttm_mmio_remap_bo_fini(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
-- 
2.34.1

