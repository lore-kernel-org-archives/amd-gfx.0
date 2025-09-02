Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB25DCA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 15:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9113D10E78F;
	Tue,  2 Sep 2025 15:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W10CP22j";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C49E110E78F
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 15:00:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBKBJkhbw0BGF24SeJZ7W7VO151bmJaCH3q4MnzXG6efubuOId1LgO52cb1dECLaYs+2AdA1j2jfj8ZQg132Br1d2qA9GV9CPGu/4ioVEgEhkQXrGT96cuvMt8PswucRM6ix1fDvAHai9vXd1GCLOFV5o/jwmxU4fcNtnrxBxncDGlXaJtPQxgiuQB2h7/Vtnf+MYWbiWDdhsZfiW+6s/TWU6gJybGrWBvaIneJCyVN08Fymw7WeF8GTBig/uPv0wFmcarZ52VbkIY6e75OHEtAgAXlGE+bNKhh6cV2moWJW3IhIKbIewe4hE9qzkPZF/iRVAg633bQJZUt9GEmViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKusgKgkn4VxNxHF2XA3ta1XBvloSuhH/k2DUV+X2eE=;
 b=kI9IosyI94q97vy9J6DuBsENZX5p89JdXCEu89AFubBakoA3fpfVp4ngAtmc+qnQoxVq+mN7ZSkU9AAwqyNGMFckfvQVYcjsVzBS8bKGdk6I+Eq8Oe3IUQWn7cOOOc7uHT1qYHTMjVGOlehboTSsQ/uZcJGM3DFNqrR6TFXXwMkfVETWdDaxNJ3hrmd0o1cCEOHpA49qp+bFOtjlWfBuzSDycjocZPOk1eyJp8P+SxfwFSZgMPzL9whHR8cyL/PSVNklBTIZn1YqvqpkXNTxwwVJ5hoFZRbXbo0jvmxtTbhPXHr0jiwQCfG7W7/UoHGI4e9WCDziZewF3arIGa5lUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKusgKgkn4VxNxHF2XA3ta1XBvloSuhH/k2DUV+X2eE=;
 b=W10CP22jxav8YWAMqJ97pceqhvNkbHuIj2TQPM0DCtsTweJZELQwM01MgpnE0uFGsSAOQ43kMy+c819pmMRVZUKy/LVf7ZWUAz/o9Xb6mEMC8/hR4W0q5qw7oFMadmcMLQiVKXTSLbwIjDlaqfkl6xkCUYmqwcbFvTeKJDJ0zZ0=
Received: from MW4PR04CA0277.namprd04.prod.outlook.com (2603:10b6:303:89::12)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Tue, 2 Sep
 2025 15:00:46 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::a) by MW4PR04CA0277.outlook.office365.com
 (2603:10b6:303:89::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Tue,
 2 Sep 2025 15:00:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 15:00:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 2 Sep
 2025 10:00:43 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Tue, 2 Sep 2025 08:00:42 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v7 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP Singleton
Date: Tue, 2 Sep 2025 20:22:12 +0530
Message-ID: <20250902145213.486199-8-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: da6715d2-0f79-4ad7-5528-08ddea317e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFFUREZwOGdmTWlzUFg2QWdSck9pZEZNbG9Od2w2VTEyMnlBeEF4NElKRFp6?=
 =?utf-8?B?TGdnVlJIUEZJVWMwdENPSkc1M3JTQ0QybGs0cy9GcnMxdjZWWDZ5VDFhRXJL?=
 =?utf-8?B?Q3YwQmhuYkEwSlloMUd4dzZqL1JtNGhnekdvS0wzTHVTQnJLOFNicUw5cDM0?=
 =?utf-8?B?UzYvb01Hd3JtZGEwdU44d1VQTXhpeFF4SS9sVFhZUmNlNk9hTmpMUExBS2hj?=
 =?utf-8?B?b0p1V01zTGRlYk9CaHRucGV4c1JpaUZTUzZ5ZkVrSk1KajlscG54RFpYRTBU?=
 =?utf-8?B?ajhHeGdyV2xVYUhpdkhTeDBZV0VMVGtlOFJQaFMzeWlKSUFlTDRBMUI5ZWw5?=
 =?utf-8?B?ZVZyMXZzMmxDNFRCRGtTb1pLUmg1ZUFZWi96am1XQVd4UTQvY1RUcE5tRDZK?=
 =?utf-8?B?cklxYVVPR1ZjS09TcjF2a1hqcUVCZHZQU1h4TW5ua1ZYWXB2Y0ZNUnBYalgy?=
 =?utf-8?B?MWlodkozdU01TkQ5NnV3R1hicVNJL1lNbDN2Rkg2VlpDajJITkhYblRVT0I2?=
 =?utf-8?B?TlZDQnVGVmhYdGtwZTdBN3JCTzRHaUVqSm1MNkFnalhjMVhxS0xpWW9XNUR4?=
 =?utf-8?B?UHgvQ3NWYTV0ZmExTkVKVlBicmsrQ3dOMDdWZXlSbXZkMlYyYmovWVY4Ym1D?=
 =?utf-8?B?bmFrVWlmR1gvVzJOV0JSNUpvQkI5Rit6T1BGQVQzT3NDMWRRWGdVRkdaajlm?=
 =?utf-8?B?VEdhY2tKOVh0THdEWG5VNTZEUjEyb2Z2SkJRQnVwZzJkaXZkOWpFSk1XYTZm?=
 =?utf-8?B?dmVHS2N4Rm4wNVdoNTNjVWpodFZSenBUUlBobTZTa0ZFMFZrWVdkdE5oM0VM?=
 =?utf-8?B?bmhyUUFMa3JFdm43TXFNZVBSeDV3ZC9mL3R3dDdrMk14aGJDTEp0SElrZTNw?=
 =?utf-8?B?eEZvQnRHcUpqSEpVZDY5NU5xNm81bkJibUgya05hQndYQ0xac1NmRURvVUlI?=
 =?utf-8?B?cllwcnFrcDVYK3RuejJJQ0pSbXR2V2I4TjI3NXRrN3VNZUVLajIydGpFZWtz?=
 =?utf-8?B?U09Ta1FISkh4a2w0K3lheW1ySE9mRFJaNk9DSnArTmxablk2QjA5Q1pHMmhL?=
 =?utf-8?B?MFVlZHFTN1E5clBsVXE5bzdkdWgvSUo4Wlo5SS9oRWxOejFZNVZOaG1nRWlG?=
 =?utf-8?B?bUpQOTZyL2dKM2d4L0ZYTUdvQ1llWGc2SU1CYjZSQWhXais0bUVGc09NQW5L?=
 =?utf-8?B?dVUrcVd5dTduUTVNWWFVSkpXOEdubGZFMGZTZ0ovazMxbi9KUnhwb21pT0lD?=
 =?utf-8?B?VVo1VEU1bGRMbVJsdlF2WGFmSFJkSXhMUTAxMmZkZkxVV0RvRVlYb0doZS9y?=
 =?utf-8?B?ZVlRV2xnaUtlTCswVnZadDdMcExaUjhvTjJDendnVk1lNUMvRDJ3MjB0aEZu?=
 =?utf-8?B?dEUzM3NzOUFEb0dxS3gzVjVLNnBHT0JNYU9pR2Z0c24wcFNEQWVjb0hzdlhZ?=
 =?utf-8?B?OW8reGkwRXZpTXFWT3RiZU5jVlM2a1FpNGZXejNBSnFJeDJrUVhaZXZ3MXlT?=
 =?utf-8?B?Z0hmc015OEgrUTQ2QjIxU1NEdktSby9mWnFvZUUzL2VFbWxVcVdzRlh3emk4?=
 =?utf-8?B?V2xVUGNHc1Jrb3I0T1JVOW9VdDBxOTV4eDJaUVdVSGRhRjZoSmhyWEJmeWM0?=
 =?utf-8?B?OCtSWWNjYWd0N3cvVGRVSlJENkYwQW1DcjI5ZmtaM3JsekhjTFpDUlJyanNz?=
 =?utf-8?B?NFVGNFJnYyt2ZStFbmVCZ3NRU3NwZm1pSzU0V0REWjFWUFRRaDVncmNCSlEv?=
 =?utf-8?B?VDhJNGh2ZXppUENmVDhGYW1lMDZtNXFvMkZ6eTkvazVsL2NTVGpiSHRhWTRp?=
 =?utf-8?B?TXlqWEgvL1prTmE2QTQ1VlRLMmE3RXF6Mm1zYjV5S1IvNUlzU2hPV3R5dXNJ?=
 =?utf-8?B?ZisyVTE2ZDlzL05ySll3VTVoUzQwL3FLRVdrc0g3WmFOL2k3N2hjMTczSER0?=
 =?utf-8?B?ek5NdXQrUFo2RFZRMnNNczU1OXZuWmlSbG83aGJ1US9jMmV3L29yUEs3U0ZE?=
 =?utf-8?B?azZua1U5V2FJZ01NczNrd1hTam92U0NPUW9KbGNEUFlMaGVlTWtqUWJXVHMv?=
 =?utf-8?Q?/9aO7x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 15:00:44.1039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6715d2-0f79-4ad7-5528-08ddea317e01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
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
 - Squash bookkeeping into this patch (Christian)

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 59 +++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

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
index 1a68ba17a62d..f38bc9542cd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1854,6 +1854,59 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
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
+	return 0;
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
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->rmmio_remap.bo = NULL;
+}
+
 /*
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
@@ -2028,6 +2081,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
@@ -2091,6 +2149,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
+	amdgpu_ttm_mmio_remap_bo_fini(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
-- 
2.34.1

