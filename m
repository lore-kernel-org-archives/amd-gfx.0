Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FFB5C531DF
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 00:05:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 674C710E339;
	Thu, 15 Aug 2024 00:05:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gkwkpGz4";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 163E110E32E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 00:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTHO16e0xi4jsH0x4yVnGJhOQwq/0M6Wk0YhuzXsqXDRpmUg1qrsRrHWOgIApCqA4qU9fl6uAtPJEPX1Ac+dq8SOKkL6mgC9kIeQ3DmSxhoG2e9O2hmuuEltcfoYrjscxdmkimiX3zGHtmGziiix/ipVDQllqb0051eHZrJVu5EbIjF2DI4fyL11WKzhIGCfFeWtNI3PJno8GYchbTlbHUeluNkC1W7ZWAEpE6hA/JSKEwmacvvzVS3xEUZQXnlWDU6FXbiokqkNteib5eMSK6DU0AmxZRnY/gOlHTSQlF7jPuiq7Lr7WlOMUkWhIQxks5MmEjW8oz547EXPT3Mwvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlUKntlkdof33rjbl0BKYn3uccMi07rhTYQKX3vw7LQ=;
 b=RidHZPU85MCcvid4dp0xfOB660esF58gcEUj1W2ArqzpjkeFZgL8P+GXXhXoatLyX0wsTfQTNAJnBCylJZ8Scf0Ml7hxuw6rz9gaVanye3vY8M/BHzenrAO6nj/gqxFajxr38td6OAMlYXWvDOPaPzPhTKnA/4Tv0cpNRdNmY6Rd30Y3T4QkFUIPwYNXfKlKmPsK4ZWgujFzFhMy/yBjs0MxUfAEUG8cDZKSePYPNaGH7Sy1wPY/GEIKUWIRJJIhzILXWhpk7KbjJvjPe8BB3QIBQzFIDUIvQ03vdMx8uiVHjnKhL0XQGb7W1CJaThrC7fuKyJY8c36NsXvwwr0vcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlUKntlkdof33rjbl0BKYn3uccMi07rhTYQKX3vw7LQ=;
 b=gkwkpGz4AP9AeymMsYaFAec6S7kWjBvW3LdXeAAInDzm54sEYYftDTqZ5gW9q1U0Uhk+R/OSNVRSAAiVYE8m2knfkjXMC5dqSloW+3Cke3o3kDNZ8IAUUP2e9fD8yUe6e55D0mk+4s9E6WLQ6CGNxMmxvNAmzqNDyqAkQoPNp2U=
Received: from BL1P221CA0027.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::8)
 by IA1PR12MB7686.namprd12.prod.outlook.com (2603:10b6:208:422::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 00:05:23 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::65) by BL1P221CA0027.outlook.office365.com
 (2603:10b6:208:2c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 00:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 00:05:23 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 19:05:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 09/17] drm/amdgpu/gfx9: Implement cleaner shader support for
 GFX9 hardware
Date: Wed, 14 Aug 2024 20:04:53 -0400
Message-ID: <20240815000501.1845226-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815000501.1845226-1-alexander.deucher@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: 28e22fd6-d778-494d-4bc2-08dcbcbdf5ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OEQ0RVZFNEtacllRWUVTL0lHUUhPdjFkTkI5cktnQkM0M2xwbkRGNXpia1NN?=
 =?utf-8?B?eHlmRVZ1NVhyd1ZzZUgwQmFUamlOeEZSK1ZUWktkTzh3U3hWam9kRFE5U0I0?=
 =?utf-8?B?RHZGUHZVUGRPV0ZZV1VRN1lLTW0yOEhuR2VOLzVYZ0lDWlFEVmpUaURvUE1r?=
 =?utf-8?B?aDVLMlVsQUN1YVZhNTBvaEE0am02ZlMrd002SHRYY0VRandJR2dFaXZ0TS9J?=
 =?utf-8?B?YVdQUmZVMUwvNnFkc3ZPRDlJWHRVYWVhTGNFa1M5V0g3djh0VlNYODFuYXlm?=
 =?utf-8?B?UkczQU5ncjlIKzhvQ3JWdXZabGV5aGJhOVFMQm5ZOGFvSCtyNnNkczRYbS9S?=
 =?utf-8?B?ZzIvM2xUUkhTTHlvV0syQlpFUWN0dlZRdnE5Tktod2NxQjY0UlIxYXRWc1Av?=
 =?utf-8?B?YjBRTlgrYStKQkk1Mk1TUXJhNUt6UlZVNHVWSUxaL0RCM3R6TU9QeUgwaGtn?=
 =?utf-8?B?RjFmazU0Mmt0OC9ZNTZZaTJFM3RrZmhwNG5WQ2Nmbkc3UDMrd2JzNER5dXRJ?=
 =?utf-8?B?bjkyMCt6ejE1ME1zdFBvdmJUaHl2Ulh1UXJ6UW5LV1NGV0FWallDdksxbmtW?=
 =?utf-8?B?MEZrODFOQVNDUUNXK0RtbVpyTDFaSHFjUjlkN2RMek1mNHZhZnRIM0FvQkd4?=
 =?utf-8?B?RFk1VGN3UFNlcVBaRW9qazVNOFNOMUNldVV0STBYUWlzc3JuUW1Ody8zMVhW?=
 =?utf-8?B?SklMc3NCcjZQRytnbTVTazIxRGh2L2lrWUpSUUF6eFdFRnFDaFkvekQya25o?=
 =?utf-8?B?aUsvMElpNXNYYTV1Zyt6RDVadnk3RVFYN3l3YUtmMWZIbjFldllTaEJwV3gv?=
 =?utf-8?B?QWNNbWdrSjU5M3VpNUdLNUpFbDhnNkw3Y3lBSU5LY1lPT2xBM3F4S0thcVZ0?=
 =?utf-8?B?dE5wNGlaVDdHaXB1VkNVRzU4MlFYYjhHWG5CY1lMWUJUaTUweDI4QWJZeFNu?=
 =?utf-8?B?d3R5YTBPeThKOFFRWWptOTFDeXVZS3pXRmpsUE5EQS85RWRXK1JBZDdsbGw3?=
 =?utf-8?B?QUhWZkR6bFZ2ZG10WHRiMTdybjFoMTNrMGM5ekhSRk51T2VvK0NlTCtPY3dw?=
 =?utf-8?B?OXRZYzdxeTkydDhWRytMR1hiaDRzMHE5czFxSlVqMkJPRU9LTS9KMlR5Vngw?=
 =?utf-8?B?RGEvK2t2SzN3ZTlHYXVTcTU1VENNSUs5TmRucFA5UVBrdWgxcXR3aW5FckhT?=
 =?utf-8?B?U01BZjBJOHJXWUQ3WTFGWnpqUDJ6Y3dMeWFJa3ZhQ3hxT1JBazUrQnVaWHEv?=
 =?utf-8?B?RE8zR2ZDa1ZlQmp1VFpDYVZaZTYyMWo1R1I2V3VLaGpIVnpqRFg5RURKZTdh?=
 =?utf-8?B?bW9VbkVEWExmNnNFQnY5QnBjT2I5d3R5WmxzaUVlalFUczZVbS81YUNSVjYv?=
 =?utf-8?B?d3RBSGxra2V5dzNnY0NoK3c2REhFUE9jbGh6SDI4UFVBY3RiRUZzL1VlTFo2?=
 =?utf-8?B?WGk4NXdXUEcxTHJzdEZ5NDFjNzBWNXBja0wrdmRsTnBQOTZDL2JuVTROemE4?=
 =?utf-8?B?YXhITFJVSExiQ2dnQ25YaitndHArTzA4Q3BoN0RzK3drbGRleFlLc2ZHa0d6?=
 =?utf-8?B?Q01SYitwZFowWlZBMnJ0NzR0cVBoY3NvRWs0Myt6VmtjWXYrVDhNcnpYUVJJ?=
 =?utf-8?B?L0VNM21nNXArejVPOGhtMWoySmYxQlJpUFcyZHRRWTJIVUdYZ3E0TUE2V1dP?=
 =?utf-8?B?U09vMDd0U2ZKZkp4ei9EK2NOVlVjMndsa3A4T0U5bDdWK0pwQ0JjN2MrYnln?=
 =?utf-8?B?TGRHWmlpeGN6K3grNU5KaU5NSW5OMGo0cFlnMEV2MFE1OElPbTQvYmlmUkFm?=
 =?utf-8?B?MnovRlZ5VDJRTFMydGFmS3pGTzQzR2JzQnJUM1JQTmNkNlNya1hDYm8wTnZK?=
 =?utf-8?B?cytzY2dVTmZvb282NGdGZjlibi8rU2ZFaEppU1B5aXZLRWJUV2Y1ZUljV0Fq?=
 =?utf-8?Q?UsV57NxOLLoMEX+vbSar9FVy8BuLdfQo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 00:05:23.5627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e22fd6-d778-494d-4bc2-08dcbcbdf5ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7686
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

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

The patch modifies the gfx_v9_0_kiq_set_resources function to write
the cleaner shader's memory controller address to the ring buffer. It
also adds a new function, gfx_v9_0_ring_emit_cleaner_shader, which
emits the PACKET3_RUN_CLEANER_SHADER packet to the ring buffer.

This patch adds support for the PACKET3_RUN_CLEANER_SHADER packet in the
gfx_v9_0 module. This packet is used to emit the cleaner shader, which
is used to clear GPU memory before it's reused, helping to prevent data
leakage between different processes.

Finally, the patch updates the ring function structures to include the
new gfx_v9_0_ring_emit_cleaner_shader function. This allows the
cleaner shader to be emitted as part of the ring's operations.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 45 ++++++++++++++++---
 .../drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h  | 26 +++++++++++
 2 files changed, 66 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index db21fb951e0e..3045b8b0796d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -50,6 +50,7 @@
 #include "amdgpu_ring_mux.h"
 #include "gfx_v9_4.h"
 #include "gfx_v9_0.h"
+#include "gfx_v9_0_cleaner_shader.h"
 #include "gfx_v9_4_2.h"
 
 #include "asic_reg/pwr/pwr_10_0_offset.h"
@@ -899,6 +900,12 @@ static void gfx_v9_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 				uint64_t queue_mask)
 {
+	struct amdgpu_device *adev = kiq_ring->adev;
+	u64 shader_mc_addr;
+
+	/* Cleaner shader MC address */
+	shader_mc_addr = adev->gfx.cleaner_shader_gpu_addr >> 8;
+
 	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
 	amdgpu_ring_write(kiq_ring,
 		PACKET3_SET_RESOURCES_VMID_MASK(0) |
@@ -908,8 +915,8 @@ static void gfx_v9_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
 			lower_32_bits(queue_mask));	/* queue mask lo */
 	amdgpu_ring_write(kiq_ring,
 			upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
+	amdgpu_ring_write(kiq_ring, lower_32_bits(shader_mc_addr)); /* cleaner shader addr lo */
+	amdgpu_ring_write(kiq_ring, upper_32_bits(shader_mc_addr)); /* cleaner shader addr hi */
 	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
 	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
 }
@@ -2211,6 +2218,12 @@ static int gfx_v9_0_sw_init(void *handle)
 		break;
 	}
 
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	default:
+		adev->gfx.enable_cleaner_shader = false;
+		break;
+	}
+
 	adev->gfx.mec.num_pipe_per_mec = 4;
 	adev->gfx.mec.num_queue_per_pipe = 8;
 
@@ -2373,6 +2386,10 @@ static int gfx_v9_0_sw_init(void *handle)
 
 	gfx_v9_0_alloc_ip_dump(adev);
 
+	r = amdgpu_gfx_sysfs_isolation_shader_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -2408,6 +2425,8 @@ static int gfx_v9_0_sw_fini(void *handle)
 	}
 	gfx_v9_0_free_microcode(adev);
 
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
 
@@ -3952,6 +3971,9 @@ static int gfx_v9_0_hw_init(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
+	amdgpu_gfx_cleaner_shader_init(adev, adev->gfx.cleaner_shader_size,
+				       adev->gfx.cleaner_shader_ptr);
+
 	if (!amdgpu_sriov_vf(adev))
 		gfx_v9_0_init_golden_registers(adev);
 
@@ -7368,6 +7390,13 @@ static void gfx_v9_ip_dump(void *handle)
 
 }
 
+static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
+{
+	/* Emit the cleaner shader */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+}
+
 static const struct amd_ip_funcs gfx_v9_0_ip_funcs = {
 	.name = "gfx_v9_0",
 	.early_init = gfx_v9_0_early_init,
@@ -7417,7 +7446,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 		5 + /* HDP_INVL */
 		8 + 8 + /* FENCE x2 */
 		2 + /* SWITCH_BUFFER */
-		7, /* gfx_v9_0_emit_mem_sync */
+		7 + /* gfx_v9_0_emit_mem_sync */
+		2, /* gfx_v9_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
@@ -7439,6 +7469,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_gfx = {
 	.soft_recovery = gfx_v9_0_ring_soft_recovery,
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.reset = gfx_v9_0_reset_kgq,
+	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
@@ -7471,7 +7502,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 		5 + /* HDP_INVL */
 		8 + 8 + /* FENCE x2 */
 		2 + /* SWITCH_BUFFER */
-		7, /* gfx_v9_0_emit_mem_sync */
+		7 + /* gfx_v9_0_emit_mem_sync */
+		2, /* gfx_v9_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	4, /* gfx_v9_0_ring_emit_ib_gfx */
 	.emit_ib = gfx_v9_0_ring_emit_ib_gfx,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
@@ -7495,6 +7527,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_ring_funcs_gfx = {
 	.patch_cntl = gfx_v9_0_ring_patch_cntl,
 	.patch_de = gfx_v9_0_ring_patch_de_meta,
 	.patch_ce = gfx_v9_0_ring_patch_ce_meta,
+	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
@@ -7515,7 +7548,8 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 		8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + /* gfx_v9_0_emit_mem_sync */
 		5 + /* gfx_v9_0_emit_wave_limit for updating mmSPI_WCL_PIPE_PERCENT_GFX register */
-		15, /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
+		15 + /* for updating 3 mmSPI_WCL_PIPE_PERCENT_CS registers */
+		2, /* gfx_v9_0_ring_emit_cleaner_shader */
 	.emit_ib_size =	7, /* gfx_v9_0_ring_emit_ib_compute */
 	.emit_ib = gfx_v9_0_ring_emit_ib_compute,
 	.emit_fence = gfx_v9_0_ring_emit_fence,
@@ -7534,6 +7568,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_compute = {
 	.emit_mem_sync = gfx_v9_0_emit_mem_sync,
 	.emit_wave_limit = gfx_v9_0_emit_wave_limit,
 	.reset = gfx_v9_0_reset_kcq,
+	.emit_cleaner_shader = gfx_v9_0_ring_emit_cleaner_shader,
 };
 
 static const struct amdgpu_ring_funcs gfx_v9_0_ring_funcs_kiq = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
new file mode 100644
index 000000000000..36c0292b5110
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+/* Define the cleaner shader gfx_9_0 */
+static const u32 __maybe_unused gfx_9_0_cleaner_shader_hex[] = {
+	/* Add the cleaner shader code here */
+};
-- 
2.46.0

