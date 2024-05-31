Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3102DC25B75
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A9E10E190;
	Fri, 31 May 2024 16:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3UvYYmcE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EFD410E080
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlkYuoRooGFgvKiYBXi7GNovzeyM2sn406A7W0QxUcs1QEZSHaiWw2EFc7ee9hDBI1QS/syLFsD2bqXUHCW37J7+ke55xC+2z2sNSqxFU0Ei+tiLivnqpG+2QZ3GqjbxK9JUABl48a+OQPL0bwozo+6WH10KdQqp4GkSnYjVJP6qYT8sdj4hKlGa//7Bafij5RJGrSlG011DNPHLNpUArcSpvFxS5EAZpzCBnaYnY6I7diNiXhRuLayGLtNke9+Jus6sUFpSAigHdUITxmZJ7rkOZPhRYaA8vy3Tr3CQrJ361BH0heT4nCRjbLKkigvfVWAkJFFangEG1mOkHLspwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoCoXW94GBS/EOa8o/95ce3jKPLuOFrdR3Z+UTCuMB4=;
 b=MBEbkQXWxaGRbkQFO0zSussOJpioO0EQxqOvJnyG2cTYFq/BZaKVTn2kuuWHH79qDnLE6FbB3U729ueww8KZZl6RYa04kJK6ReQ6y/R/a8fQGWkX5+TBFV05ND9DywWPiuiPxEcfat1fFZTeuwwqPWQWaPDYUh0hfhtrYI+2O0sXhmUmtwofCYecBrKqSlsV+LNKgHmdN/px2ONMSqYVlQLjra8EWnkOHMFJY+vAjD5eF8wRyrbSXY5afz1aTjuz2KsWIE/EpbgzMu1jk9XHakfxQLKNFJ5ZtkFjm/ikOG27OX9KSeibGEo2O2NlFGlzxsHSI3E58T9suWMCebGX6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoCoXW94GBS/EOa8o/95ce3jKPLuOFrdR3Z+UTCuMB4=;
 b=3UvYYmcEyFWD317tCz/fvGYg40f+zgBzJyb5HrtudZ3ZaNjdXn7AGgpdNoxSJxGegGcdrnVnmDV220nNYD308DXLEyMNk5pROGZY4XPTSFlNj7aOBBhgDDuKUawVzCXt/gXNX6P9p2JF2URciSXZbPv1l0m2dtB/VPOmmVDBzfw=
Received: from MW4PR03CA0049.namprd03.prod.outlook.com (2603:10b6:303:8e::24)
 by DM4PR12MB6565.namprd12.prod.outlook.com (2603:10b6:8:8c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 16:07:57 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::d7) by MW4PR03CA0049.outlook.office365.com
 (2603:10b6:303:8e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25 via Frontend
 Transport; Fri, 31 May 2024 16:07:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7656.0 via Frontend Transport; Fri, 31 May 2024 16:07:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:07:54 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: add sdma 7.0 support for copy dcc buffer
Date: Fri, 31 May 2024 12:07:35 -0400
Message-ID: <20240531160735.3547360-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531160735.3547360-1-alexander.deucher@amd.com>
References: <20240531160735.3547360-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|DM4PR12MB6565:EE_
X-MS-Office365-Filtering-Correlation-Id: 7edcef7e-5845-42c8-e6e4-08dc818bd64a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|36860700004|376005|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXhHVWZzSzA3MmlvY3RLeHpFYnMzQzhuZnR5Y1Y1Zk1qVXlaWUdNdTJCeDRT?=
 =?utf-8?B?UkpyOWJOSm93bFM5UG0yVktNNTFEdHE1RWNzb3ZSbEtyaVlDU3l6Ni90T3NR?=
 =?utf-8?B?YkhnanpnbjZkYUFPVWhwZkxwcE1LNTQxdGNDbElvazNDMXZXNXlJdm5aWHhq?=
 =?utf-8?B?TllPUU1qNmx1am5tYjRKY1BKWEs2Ri9EdzZmKyt0MUxsTXY4b2ZrbStkTnR5?=
 =?utf-8?B?eDlCcjZVV2Vkd3BsTkRxSlNCSUc5MDA1MXJkem9WcmFFd0VLVlJKWnkrQ3pz?=
 =?utf-8?B?YW83TlZEL0FhMlROSUhocVExWTNyNkg5VFhPK3p3SENENUwwWjczaS9jQjZ5?=
 =?utf-8?B?YnZESDRhd2ltRHByYnhkNFV3YTh2NUU4SVV6aHJKZlJkeUIyclI5aTYrV05S?=
 =?utf-8?B?cDd6bDBENFVGN1lNOEdTVG5zenVoT0hka040RTZra1RlWEl2cmZ3aWZuVjBM?=
 =?utf-8?B?RXU0VytESExydTg4QnBmWWQrcW5KNVVJTjZXVk5FNmlsbVpsUzNKdHlqZWdV?=
 =?utf-8?B?OU1tRGt1WEhZNWRkK0NhR3cyMEFOWnJZa2w4V1VmSkZDOXZvTzkrdnF4SGQ0?=
 =?utf-8?B?VHlTZ01Hb1BDdDRSK2VxMTBKOGlsL3NoVENONXRCMTd6aGpMdTdodm5QbHBP?=
 =?utf-8?B?MXo0MHVhL1hnUUY4MVRkN3J4aER6bDNXRnRUL1FZLytob0JBdTBpTW1SRnV0?=
 =?utf-8?B?RG5TbWFlT0lyd1F4TlpidThaYThtWVk4STNHTlp2U0xvRnlST3lySUJhTkNB?=
 =?utf-8?B?dENsc1lMd3NWQTNDWUt2RVRHTU1hNGtzYkV1RFdGNlNqU1pqUklzRW5EN1Nh?=
 =?utf-8?B?MUpUOEhkUjVUb09wRGJnRUVreXRpVlJzWU9XUVNnMUxFRnl6ZXZmL3cxUUFn?=
 =?utf-8?B?WTBwQXg0Sm0rbHg1SDBDR0dZbU92WVpHaU5qUk1hWXhwRTNIeHZBRTd5bGpo?=
 =?utf-8?B?dkM3OHJJeUdJOS9TSUtIdGtyWDdscEdmc09yT0Q4bkxpd1lFMUc3ZXplM2wy?=
 =?utf-8?B?OEt1bUUwTFA4cml2aG5LaE1NUW42UUI1d25Qakw3c0h3U2RMSEtvZXB0V3Np?=
 =?utf-8?B?UUFTZ1RtekJCVk42Q3BNRVJURVQwbkNBVGkzejkvN0JYK1VlM1JCdENqdVFa?=
 =?utf-8?B?bTZzbGlHallscXFzYmJjUFJQYVBvc2x6Y0s3a0lmbEtnQXdIVTdvZ094UFg3?=
 =?utf-8?B?SmJub0pUUmZFSVVqSlhISnhDMWVtUjhMaWQ0YzRkU2pCaGNLT3VPS0RoS2ln?=
 =?utf-8?B?ZllHNUgzbXpOdEw1VlFTVnZQZWp5MFJWZkEyVXA0VEdGU0ZRaDVxQlViQ3N1?=
 =?utf-8?B?VVZQb3ptZ0NGSGFBM1ErVkFCL1ZKQ21jYnNrWDRFSmwyYzRReWNNY1NtLzFJ?=
 =?utf-8?B?VThENlNrYmp3Mk9JcG5iWFR4d2lGWlhLdGpadTFUOGdWYkpYdmljTWVXV3BV?=
 =?utf-8?B?c01yMWkxTm1HaUVCY0t1ZktkVTVZY3IycEo0MDBkNWVZRmZTZlV3dHcyL20r?=
 =?utf-8?B?dlA5dExiYzhWdFJhNWdTLytkOHcvbHZQR2ZEZ2JuNWN0T3ZRRWRXS3NETHp2?=
 =?utf-8?B?ZmVISERxeGpobk14eHRBalhHQWZIaGpDbTBuYkNtbGNVdTBXbkFMRmJxeFY5?=
 =?utf-8?B?d1EwamNiZ0RHTVJUMEtlam1OclRXc3U1M0hpN1JzYVJyM0hacjFyZGpSdW41?=
 =?utf-8?B?RWNaOU0waTQvazVDbG90b01xTDkzeFVVeWtsbW9kUW14ZXJLOGQ1UkNFTEpC?=
 =?utf-8?B?ekdQMWRkRWFEN0l3TnR4WVdTeFduOU55YTBpNDBaZVczRXg4NTRqZi8zd2U2?=
 =?utf-8?B?VWtDK0dlN1p6dUZyT2NVN3o2VytYWDBuT3JhYmJiclJDakdnekhzNmFuc1dM?=
 =?utf-8?Q?XN5aVcGGivT2f?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:07:57.4031 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7edcef7e-5845-42c8-e6e4-08dc818bd64a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6565
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

From: Frank Min <Frank.Min@amd.com>

1. Add dcc buffer flag for copy buffer
2. Add sdma 7.0 support copy dcc buffer

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Frank Min <Frank.Min@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c           |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h           |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h |  8 ++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 12 ++++++++++--
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0364a7bb5893..7c0907cd8b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -295,8 +295,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	struct amdgpu_res_cursor src_mm, dst_mm;
 	struct dma_fence *fence = NULL;
 	int r = 0;
-
 	uint32_t copy_flags = 0;
+	struct amdgpu_bo *abo_src, *abo_dst;
 
 	if (!adev->mman.buffer_funcs_enabled) {
 		DRM_ERROR("Trying to move memory with ring turned off.\n");
@@ -325,8 +325,14 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		if (r)
 			goto error;
 
+		abo_src = ttm_to_amdgpu_bo(src->bo);
+		abo_dst = ttm_to_amdgpu_bo(dst->bo);
 		if (tmz)
 			copy_flags |= AMDGPU_COPY_FLAGS_TMZ;
+		if (abo_src->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+			copy_flags |= AMDGPU_COPY_FLAGS_READ_DECOMPRESSED;
+		if (abo_dst->flags & AMDGPU_GEM_CREATE_GFX12_DCC)
+			copy_flags |= AMDGPU_COPY_FLAGS_WRITE_COMPRESSED;
 
 		r = amdgpu_copy_buffer(ring, from, to, cur_size, resv,
 				       &next, false, true, copy_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 53d5a5990c31..7c903a6c9ddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -112,6 +112,8 @@ struct amdgpu_copy_mem {
 };
 
 #define AMDGPU_COPY_FLAGS_TMZ		(1 << 0)
+#define AMDGPU_COPY_FLAGS_READ_DECOMPRESSED	(1 << 1)
+#define AMDGPU_COPY_FLAGS_WRITE_COMPRESSED	(1 << 2)
 
 int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size);
 void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev);
@@ -148,7 +150,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
 void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
 					bool enable);
-
 int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
 		       uint64_t dst_offset, uint32_t byte_count,
 		       struct dma_resv *resv,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
index 6af23e7888ca..d8cf830916b9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0_0_pkt_open.h
@@ -91,6 +91,14 @@
 #define SDMA_GCR_GLM_WB			(1 << 4)
 #define SDMA_GCR_GL1_RANGE(x)		(((x) & 0x3) << 2)
 #define SDMA_GCR_GLI_INV(x)		(((x) & 0x3) << 0)
+
+#define SDMA_DCC_DATA_FORMAT(x) ((x) & 0x3f)
+#define SDMA_DCC_NUM_TYPE(x) (((x) & 0x7) << 9)
+#define SDMA_DCC_READ_CM(x) (((x) & 0x3) << 16)
+#define SDMA_DCC_WRITE_CM(x) (((x) & 0x3) << 18)
+#define SDMA_DCC_MAX_COM(x) (((x) & 0x3) << 24)
+#define SDMA_DCC_MAX_UCOM(x) (((x) & 0x1) << 26)
+
 /*
 ** Definitions for SDMA_PKT_COPY_LINEAR packet
 */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index ab1dea77be6e..96514fd77e35 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1568,13 +1568,22 @@ static void sdma_v7_0_emit_copy_buffer(struct amdgpu_ib *ib,
 {
 	ib->ptr[ib->length_dw++] = SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_COPY) |
 		SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_COPY_LINEAR) |
-		SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_FLAGS_TMZ) ? 1 : 0);
+		SDMA_PKT_COPY_LINEAR_HEADER_TMZ((copy_flags & AMDGPU_COPY_FLAGS_TMZ) ? 1 : 0) |
+		SDMA_PKT_COPY_LINEAR_HEADER_CPV((copy_flags &
+			(AMDGPU_COPY_FLAGS_READ_DECOMPRESSED | AMDGPU_COPY_FLAGS_WRITE_COMPRESSED)) ? 1 : 0);
+
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 	ib->ptr[ib->length_dw++] = 0; /* src/dst endian swap */
 	ib->ptr[ib->length_dw++] = lower_32_bits(src_offset);
 	ib->ptr[ib->length_dw++] = upper_32_bits(src_offset);
 	ib->ptr[ib->length_dw++] = lower_32_bits(dst_offset);
 	ib->ptr[ib->length_dw++] = upper_32_bits(dst_offset);
+
+	if ((copy_flags & (AMDGPU_COPY_FLAGS_READ_DECOMPRESSED | AMDGPU_COPY_FLAGS_WRITE_COMPRESSED)))
+		ib->ptr[ib->length_dw++] = SDMA_DCC_DATA_FORMAT(4) | SDMA_DCC_NUM_TYPE(4) |
+			((copy_flags & AMDGPU_COPY_FLAGS_READ_DECOMPRESSED) ? SDMA_DCC_READ_CM(2) : 0) |
+			((copy_flags & AMDGPU_COPY_FLAGS_WRITE_COMPRESSED) ? SDMA_DCC_WRITE_CM(1) : 0) |
+			SDMA_DCC_MAX_COM(1) | SDMA_DCC_MAX_UCOM(1);
 }
 
 /**
@@ -1603,7 +1612,6 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
 	.copy_max_bytes = 0x400000,
 	.copy_num_dw = 7,
 	.emit_copy_buffer = sdma_v7_0_emit_copy_buffer,
-
 	.fill_max_bytes = 0x400000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_0_emit_fill_buffer,
-- 
2.45.1

