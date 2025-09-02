Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB680CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD4910E560;
	Tue,  2 Sep 2025 03:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JzwPbIx0";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EDF10E560
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FpdI/eKJgtSM+laJhEQH/WEOJyO10Jh8B1XFRODt3K2eLMYk6Ohu1110JXFJmijwAeeY6ZbfBiNTfM8NMoM6mWShTX00luuoRSsR/p3XPImrojDVIRQTgQOriwSWLOkIJoBCx+QPrBY+/EXMI1VcIWtPfdyw9B20JNnzuoSP/3T8hT+1mJDkJykKlvibMShOFgeP9R7Fc/un9nwosjIFvmR/j8Yht24XunBMthDyklmFkxz3nk+CnKzb4usPQ/GPpnipM/LaGqHIqq9JyrdEoX1dyik18pjCmtekjsxyVnbRR4DayfbCiCEmo7ZwEdGPEYwBcjotynZvoPZXsQN2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q03M0+5NuXE2qRCN+tK14ZQHvKEmg9ic5uSgaslq/fk=;
 b=TFhGiDBw96NzgYLjmpcfwC9Ao2+7YF9LiZ1B/wFVx19r6QgJ9BmPWFaHYdljBENJqX4wamaJU3KAebFfO3pe8ZRXc6CFZ0rE/4WzVyotZudJd2ldY+D0KlEnwtv0msgcjjntCnAVFPzaRlL/LzCKZ/NwH21OEN6mAIeiCy0j5xb9UdD8SHCuOmy7MomgHMBUfcwNphLQltCNKmIo7/KfTEguKcmjFeu3FB6pl0W+XJArNYGl+9RstkUXvIsW/0m+yFYJ1B3l4NIYCUBCFunS7CxGqQpBXQI/DVtVQp8pIBNSZ47y7YAC8KYtIWi/03St99CkmMxDO6TASBdDq0N4Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q03M0+5NuXE2qRCN+tK14ZQHvKEmg9ic5uSgaslq/fk=;
 b=JzwPbIx0c+VflRIOadkecT0I5c+DRZxfvOpnRrudyIY3cHGkjZCrtoa/Hr5BmAkgx3BDzafJDGF+otWMDpSagf4oew7PdNXaMDNUrOkMFpSlKmegVSP/gaogf0DJhhPMe9/QbhqfR2JUR3jS4wiil5+hjJX7VTbKXkfPti0H958=
Received: from BN0PR07CA0006.namprd07.prod.outlook.com (2603:10b6:408:141::23)
 by CH2PR12MB9457.namprd12.prod.outlook.com (2603:10b6:610:27c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.24; Tue, 2 Sep
 2025 03:38:00 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:141:cafe::54) by BN0PR07CA0006.outlook.office365.com
 (2603:10b6:408:141::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.16 via Frontend Transport; Tue,
 2 Sep 2025 03:38:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:38:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:37:59 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:37:58 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
Date: Tue, 2 Sep 2025 08:59:37 +0530
Message-ID: <20250902032938.468332-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CH2PR12MB9457:EE_
X-MS-Office365-Filtering-Correlation-Id: d6baaffc-eff8-4c27-3739-08dde9d21d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0pXMTZEdmZGdFVHR1NMOCt2a3ZKcGNwQ2s3OXhueG1DSG51YjlhR3FDci9M?=
 =?utf-8?B?b0JwcU5lNXQ3LzhITEw0Y2xoY2RhdWp4Z3o3YjNuQVE3WnE0N2FZV0NPblZR?=
 =?utf-8?B?MGhURmFkWXNZVTNqTG9STWZyVHh2WVBkTnFvU1lZYjN4K0ZpRnJQZk8xYS90?=
 =?utf-8?B?QkFLZkNOd09wYjBvUnVRRi9SRzVlSHpFNU1OTlE3QjZEUjJjbldFN0RzRW1i?=
 =?utf-8?B?ejVYV0syUUp1bFplenZlcmU3S041SmlqaVpIR0F1NkFDR0pwbHBXRGhURmZk?=
 =?utf-8?B?WllUT1IvRVRKM0xXSkgwZG4xejdPWmFBeHhvYjVPSzJ6b3orZXY0NllQMVN1?=
 =?utf-8?B?cHNVMnJoalhCejd0bW0wNG5PeGFUS0ZCTnFsQkxkQldHbkQrQWV6VVpWb29T?=
 =?utf-8?B?dWlxL1EvZFVsd21xd0ROdzVmdTJRamJyL3hsWnJjVCsyMTNEdVVnZ2ZzN0dz?=
 =?utf-8?B?SkRUM2RhbVhWMTRaK01PU3FPWFhuKzFTWDY5OEZNZ0dJeVBpKyt6di9wMitR?=
 =?utf-8?B?L2FRVjdRYXJ2ejEyb1k0QTBPNk1iL0JabUZVLzczWEJKckE3ZHc2N3BscGlR?=
 =?utf-8?B?UnlZamg2L1paL25WTTZYc0MzZHE3ZEo3ajJ5ZTVZVG03Ump3dCt4WFhVVWZL?=
 =?utf-8?B?Rm00TGxMNmJWekE4QnlNVHNpNTl2V0NXVHJkYkR4TUliQ0s1WkZ6aE9aWXg0?=
 =?utf-8?B?ak5TODNrdklocUVTdGRoNmxTY1pOTXNPL2IvcnJ2RlZkL05OeFdKZUR1d21y?=
 =?utf-8?B?QkhPSnhXUFNHMlpUOThpaytDVzR5ZHkraEIydGFDUkxsSStLaFFsNzhPNHJj?=
 =?utf-8?B?aHpNRzJ6enNaZ2J0ZE5JQ2lYQnllZml0dlkwaElXZ244ckdrb2hUb0ZvWDZS?=
 =?utf-8?B?ZzkzdFZSQXBxN3RYQWlxZVhJeUo0dFNXRVR2RHlhOVBPejJ5WUc3d3pWU1Qv?=
 =?utf-8?B?VUtQbGpkVHRDZmpTZDRMbGpFbk1wRVVaMHpFU3pDc2IrUmN3UXFlTzg3NnZW?=
 =?utf-8?B?cSsydFJJaXNoeGZBU3hYUDRaM3I0eWFMMnE1Z1ZKWk1tVzhoMm1lVzh2U1VQ?=
 =?utf-8?B?T3h0cHYyV3Rvb2daa2FhdHZONFdqV1Jxc1RGWS9pbFVTWEdteTFSUFFuK1FX?=
 =?utf-8?B?akx6Z1ovamdmdi9CTnpJalFBcnN1TVFHdnI3cFZ1RGl5UEpsbVBNdHQ4VzZY?=
 =?utf-8?B?blB0d0QwSlNtOE41V2lLaGlDUnU0b013YVIza2FRdVQ5eDh5Z3FwLzdRZXZl?=
 =?utf-8?B?ODJua3NscFBOVVVrSno1RzA4Y24xNGR1TnVMVEVieHlrbVgvdWU4TlBma0VG?=
 =?utf-8?B?eExnYkNsd0RDV2czRWEyOXVSMVFvMElVNm0xTkRKZ1RwaVJDd3NIdmRFODVD?=
 =?utf-8?B?bzdiTDcremRpQktNanRFYll4aTNHUm1aNitPeUhnRWlaMUlJSWl5cmk2S3N1?=
 =?utf-8?B?ZjFzamFKUmgzczh4MDUyR2piQkxBT2VBWXlXZFpBYlZnQUxrTXFuemlIUFlM?=
 =?utf-8?B?dUg2RTBHK1UvbERSOUZWWkcrVVErTWxPTTFPcXFlUmhhcXpGSGh0Ri96YUVB?=
 =?utf-8?B?SlltemgwaUk3bm0rdEJxbDJsSG5wbUx1WmJIR080dnNadGF3cXRTQjhkYTZU?=
 =?utf-8?B?bE5idDVVaTh4RHJNcndoakVGVTgxbDIzNWhGWnVFR3ZQN000U2pZaU9HcE9J?=
 =?utf-8?B?NUhGT0FpellQQjBIN2c5cUQ5Z09veDk0czdrcUVJM0V6cEpTd0ZkUjZGMnZ0?=
 =?utf-8?B?QnE5OTlUdFc5MzM2dzBYWjRFem5CZzBVN2FmK1RaYU53cFpmb1BaRCtOZTdo?=
 =?utf-8?B?QnRHSEdwRXlCVUdoZER4WklabHp1M3NQQWRoVzBhY05uTTBFWkN6ZmVUUzlw?=
 =?utf-8?B?VnlITHZYUUJNSE8zNjMvVDNEQXk5NjFWRVRxTnF0bnR3anI4QlNrdUtvZlFY?=
 =?utf-8?B?UXM2di8yelhpZDhkUFRPaTBXY3dXNjc5dDJBdGRNODZybVRHRDUra1gxc0JY?=
 =?utf-8?B?RGdKWFRsVVFjeCtjVGhBS0RNbVF3TUUxZXF5WGo5MHFaTGRQazBBelorOVpI?=
 =?utf-8?Q?qNT9uE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:38:00.2930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6baaffc-eff8-4c27-3739-08dde9d21d79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9457
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

Add mmio_remap bookkeeping to amdgpu_device and introduce
amdgpu_ttm_mmio_remap_bo_init()/fini() to manage a kernel-owned,
one-page (4K) BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP.

Bookkeeping:
  - adev->rmmio_remap.bo : kernel-owned singleton BO

The BO is allocated during TTM init when a remap bus address is available
(adev->rmmio_remap.bus_addr) and PAGE_SIZE <= AMDGPU_GPU_PAGE_SIZE (4K),
and freed during TTM fini.

v2:
 - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead of
   rmmio_base. (Alex)
 - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
   (no warn). (Alex)
 - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The object
   is stored in adev->mmio_remap.bo and will later be exposed to
   userspace via a GEM handle. (Christian)

v3:
 - Remove obvious comment before amdgpu_ttm_mmio_remap_bo_fini() call.
   (Alex)

v4:
 - Squash bookkeeping into this patch
 - Place longer declaration first; clear bp via memset
 - Reserve + pin + kmap(+kunmap) the BO at init; unpin in fini
   (Christian)

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 87 +++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ddd472e56f69..24501d3fbefe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu_device*, uint32_t, uint32_t, u
 struct amdgpu_mmio_remap {
 	u32 reg_offset;
 	resource_size_t bus_addr;
+	struct amdgpu_bo *bo;
 };
 
 /* Define the HW IP blocks will be used in driver , add more if necessary */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 1a68ba17a62d..0d03e3a6f92d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1854,6 +1854,87 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 	adev->mman.ttm_pools = NULL;
 }
 
+/**
+ * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
+ * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
+ * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
+ * GEM object (amdgpu_bo_create).
+ *
+ * Return:
+ *  * 0 on success or intentional skip (feature not present/unsupported)
+ *  * negative errno on allocation failure
+ */
+static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_bo_param bp;
+	int r;
+	void *kptr;
+
+	/* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
+	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
+		return 0;
+
+	memset(&bp, 0, sizeof(bp));
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
+	r = amdgpu_bo_reserve(adev->rmmio_remap.bo, false);
+	if (r)
+		goto err_unref;
+
+	r = amdgpu_bo_pin(adev->rmmio_remap.bo, AMDGPU_GEM_DOMAIN_MMIO_REMAP);
+	if (r)
+		goto err_unres;
+
+	r = amdgpu_bo_kmap(adev->rmmio_remap.bo, &kptr);
+	if (r)
+		goto err_unpin;
+
+	amdgpu_bo_kunmap(adev->rmmio_remap.bo);
+	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+	return 0;
+
+err_unpin:
+	amdgpu_bo_unpin(adev->rmmio_remap.bo);
+err_unres:
+	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+err_unref:
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->rmmio_remap.bo = NULL;
+	return r;
+}
+
+/**
+ * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
+ * amdgpu_ttm_mmio_remap_bo_init().
+ */
+static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, false)) {
+		amdgpu_bo_unpin(adev->rmmio_remap.bo);
+		amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+	}
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->rmmio_remap.bo = NULL;
+}
+
 /*
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
@@ -2028,6 +2109,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
@@ -2091,6 +2177,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
+	amdgpu_ttm_mmio_remap_bo_fini(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
-- 
2.34.1

