Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6247CD3431
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 09:33:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 123EA893DB;
	Wed,  4 Sep 2024 09:33:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hzYnXmlq";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD9D893DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 09:33:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5Yl+avIZfPDYTbUOGR4cRYQ4DH+XCDG9CHVGTRqSGjyCmnFlt38z7+DEy6zWUlkVXuNCPqgIJuZ/KrhgpT1pVAp9W5MGGYYm1+IRXw20QtqpvmazjIhGbFNWiPjGQvDdv/IQ+ACjIzxMo9PHGWc26Pf7Ye5XyR52huMIl+MlyppqsPJnVbmJLaZC8CGn5aabAh6ohaVMF4OpkVuenAt7JejwkoL2ga/jpuVj2v5qaonI0X6S9uERhAuFWkBHpytt8di/c/Rmdh0QKwJ+TjKH43dNVPqQ6EtuEiYKZ+4K1+drHqaufuTTHonpsZmUTGhPFc+6IEFd/p19Gd1OpNRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4KddzzaRJae4y0LV5QPie6fqjvAlobSo8SrD/lHtco=;
 b=YSb8dgSDtkOFsQUdl4/akTXEK4dZM62YFz/WXK4S3CeLbGgUz80PGR6FNEswsqeE/e9NGA2EfaWJjfNzLdEB8kMQW8LY87rlIEPqdG8Q4mV4GYcQ4NdiTs5fok/J+LwVicef3n1r6dltc1JIJTFiv8OmnjfFoygznIRwHNGqP67keLRDg4VBObPINsWq9xWdGbfcs4VUGgX4fB2GKAcVJUTBSYZbp0OOFfnnn/UNBLuAP8cY85of+EjoheLoD+FezCR8yH61wvX5UNdz4PuU2UfGdj0/Q4Lsf5rChV/8YzCmHM4mlvChXd84swMS3QFiiFW4xfAAUG9z+DtIYi7Ybg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4KddzzaRJae4y0LV5QPie6fqjvAlobSo8SrD/lHtco=;
 b=hzYnXmlqSrDEUxuCqtSordYObYxEvJZ5ivot7h2XO16gGfLAwYPzlWDbcNVlbzLnjZxtC1IXTC2Iiw+Hr52ns5qy8GB4gVfyHeaGj5PVHRzDpyu6+Hl0Lu21awMGfwlDXN1Ixlz+uwyNtoCHmWGhQfhRULAwwXTH/kc8ho9T8us=
Received: from PH0PR07CA0012.namprd07.prod.outlook.com (2603:10b6:510:5::17)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Wed, 4 Sep
 2024 09:33:34 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::6d) by PH0PR07CA0012.outlook.office365.com
 (2603:10b6:510:5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25 via Frontend
 Transport; Wed, 4 Sep 2024 09:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 09:33:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 04:33:31 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in cleaner
 shader code
Date: Wed, 4 Sep 2024 15:03:17 +0530
Message-ID: <20240904093317.1802226-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb0a06c-fcc1-42a6-74ce-08dcccc4a53f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3luYjRIZGJUUkxleFF4Q2NUc1d6NHlkbmFnYWlmUlhRSk1WYkhlZkFvRWlW?=
 =?utf-8?B?SmRqUjM5SHpqalFtdTdEMStCWno3d01odzJ3Y0tiTnJaZzNLbVNWb2hmbE1z?=
 =?utf-8?B?Y1NtLy9uNENXQUdhczBSREJENE11dUF4NnZkY3FmQ0NoNjM5MEVJdDJXT3Y3?=
 =?utf-8?B?clBoeGExQWtYM1o2TnRpRXdOOTRmbnJlOU9tcTFjaUhhYmRxSnl6Mmk2OWk4?=
 =?utf-8?B?c29OL2VqNXA0Wm43bXR0S0NjdW9oN0h0NWExSzY3aHUxUjhsb0loSU5Ja2Zt?=
 =?utf-8?B?dWx0eWJ6ZFNReWl3YXFXdzVFc29OSnk0QVg1eGV3TFJidEo3VHpaR1VyenNX?=
 =?utf-8?B?bFpGT25aUVQ0MzdUQUFpMmZPUmFRRG03MDFoUkVORDJoTnltUnlCRzhGWDhF?=
 =?utf-8?B?djBqemNXelc3dkozdTlrVERzN1Q4Vk5Xa0g3RlFQZStFQzV4NFR6aHFFanJJ?=
 =?utf-8?B?OS9PdE4vS3RGN3JFaGdkWDhtMlhqWDZtTU9adnFYV1N2TENPOXNFUWNYQWpy?=
 =?utf-8?B?U2JHMStnUlNiS2lqaVZ5dkJMUW5GZ1AzSHMwQlpOajZmZzkySmViQ2JrZEFB?=
 =?utf-8?B?S2Rxd0w5dVdSaTdzTlBGNFgvWVRwSWZ4VnVZSElsSSt6cHZMOHcyWm9FdThL?=
 =?utf-8?B?RytVMWRXYVdYWmZtWTlabW9lV1JVajN1OEphTnZhVmxVWmRlNHEzK0wyR2Y5?=
 =?utf-8?B?OW9lV2g4WlBBQW9HWk8xVGpFSmZBbG1WQmpqSHNuYWpYRU1Gdk1Hc3B1dnh5?=
 =?utf-8?B?dzJxdVBPLzZlRm5Kdmt6QW9CM2hOMW9xZUYxbEhzb2p4UDdsYUE1M2ZrTi9x?=
 =?utf-8?B?clBna0hZUmdoOHBUUW1CbnJKT1JPaEZKN0FPczAzMndPeHFZUnM4bkZ0NWg2?=
 =?utf-8?B?OTk1NmEreWsxNFNKUmZ0K1pCU2plMFg3VFJaZzdZWG9PdGM2YlZlZWgwU2lY?=
 =?utf-8?B?MHdtSC9EY2ZjOXArd3VtQjgvZHE3SkdZWU9PZ0RNVnFZdXBrTTVaOFBsczQ3?=
 =?utf-8?B?czl2aWZKaE54ajhBdXdDK0NWb3Q5RUNEZWo2MTFjKzQ4NkgvRVc4czdPRVRj?=
 =?utf-8?B?WW9vUTIyVm9BWTZydDh5cXF0WWRUL0pUbVlLZ2g1OTlia3Y4ekdjOGJKYzBI?=
 =?utf-8?B?RWU1c3pxaXVLR1NWSkc0dGxPV0hEeW5KOHRRYmJla0xSVE1sMWkyVFM4c25a?=
 =?utf-8?B?SmdlSEhZYU1zSVROdVdGb2tLQUdyMzdTTTRSOFh1UTVWSTV3ZHNITkFEalJV?=
 =?utf-8?B?RUQvRStTS0ZVQ1R1RGVjL2FjSGI2ajkzbk5PbFZEQ3NqdndUOWwzQTNMQ2g1?=
 =?utf-8?B?MjVPMEQ3VmVlQW11OXBZVU1TZlNnQzd3cXNsc1lJVloyd0NtdTZjcWIvSmo3?=
 =?utf-8?B?YTBTWGJXSXM3ZG51Q2hEc1NHQnZJNE5MaHpVWEdPWFlXdTZOMXNCbTQ2aU1Q?=
 =?utf-8?B?YmtycXZrdGxaZm85aDNyYkd0dGpEUEpqMGxyQnpFUDZkN3R3c09BS1JPOWZk?=
 =?utf-8?B?WXc5cWNQWTc3QlNsUXdsU2ZiVERBQnBUSzZqd3RSQ2pSK3FqSjU1a1JwWlkz?=
 =?utf-8?B?VmZ2NmNPeFNVQXZIc0V5alJHdzhZWmQvclFLWUVKNGVZQXpmMnJrSVJxdm0x?=
 =?utf-8?B?V3RKRjcvYTBWVCtJcEhUUVp6dnEvbjJlb0p4Y21ySjBPL3RQeFlmbVMwVk1q?=
 =?utf-8?B?VitQRVIwd094YVd6UXRiUDBaV05RbEVUNVY5K0lZeklhd00vbE5NOG9FZFFx?=
 =?utf-8?B?RjFCVUk4MDI5cnlzZGFlMUFScUkwdDFLcTZCektqSldxcjBscjF3WnZNNVlD?=
 =?utf-8?B?M09kcE12djN3RnhNTGlkcDdIeUh6SVpqZzloTFducVBJTEd3OEJCbk1KN1lD?=
 =?utf-8?B?MEdWVElOVVNJaWNLbGx4Q2FxZkhNTTJDeUN1Y0JQZmNvUFJPSU1LVUhoN2po?=
 =?utf-8?Q?eEsmF5iBTun0ORCKhXyeAQfgF58fKmI3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 09:33:33.6573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb0a06c-fcc1-42a6-74ce-08dcccc4a53f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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

This commit updates the comment style in the cleaner shader code from
`//` to `/* ... */` to adhere to the Linux kernel coding style.

The comments describe the operation of the cleaner shader, which is used
to clean LDS, SGPRs, and VGPRs. The shader uses two kernels launched
separately to clean VGPRs, LDS, and lower SGPRs, and to clean remaining
SGPRs.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 139 +++++++++---------
 1 file changed, 72 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
index d5325ef80ab0..4a61562b9bab 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
@@ -21,47 +21,52 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
-// This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 192 Dwords cleaner shader.
-//To turn this shader program on for complitaion change this to main and lower shader main to main_1
- 
-// MI300 : Clear SGPRs, VGPRs and LDS
-//   Uses two kernels launched separately:
-//   1. Clean VGPRs, LDS, and lower SGPRs
-//        Launches one workgroup per CU, each workgroup with 4x wave64 per SIMD in the CU
-//        Waves are "wave64" and have 128 VGPRs each, which uses all 512 VGPRs per SIMD
-//        Waves in the workgroup share the 64KB of LDS
-//        Each wave clears SGPRs 0 - 95. Because there are 4 waves/SIMD, this is physical SGPRs 0-383
-//        Each wave clears 128 VGPRs, so all 512 in the SIMD
-//        The first wave of the workgroup clears its 64KB of LDS
-//        The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
-//          before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
-//    2. Clean remaining SGPRs
-//        Launches a workgroup with 24 waves per workgroup, yielding 6 waves per SIMD in each CU
-//        Waves are allocating 96 SGPRs
-//          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent these waves from allocating SGPRs 0-223.
-//          As such, these 6 waves per SIMD are allocated physical SGPRs 224-799
-//        Barriers do not work for >16 waves per workgroup, so we cannot start with S_BARRIER
-//          Instead, the shader starts with an S_SETHALT 1. Once all waves are launched CP will send unhalt command
-//        The shader then clears all SGPRs allocated to it, cleaning out physical SGPRs 224-799
+/*
+ * This shader is to clean LDS, SGPRs and VGPRs. It is  first 64 Dwords or 256 bytes of 192 Dwords cleaner shader.
+ * To turn this shader program on for complitaion change this to main and lower shader main to main_1
+ *
+ * MI300 : Clear SGPRs, VGPRs and LDS
+ *   Uses two kernels launched separately:
+ *   1. Clean VGPRs, LDS, and lower SGPRs
+ *        Launches one workgroup per CU, each workgroup with 4x wave64 per SIMD in the CU
+ *        Waves are "wave64" and have 128 VGPRs each, which uses all 512 VGPRs per SIMD
+ *        Waves in the workgroup share the 64KB of LDS
+ *        Each wave clears SGPRs 0 - 95. Because there are 4 waves/SIMD, this is physical SGPRs 0-383
+ *        Each wave clears 128 VGPRs, so all 512 in the SIMD
+ *        The first wave of the workgroup clears its 64KB of LDS
+ *        The shader starts with "S_BARRIER" to ensure SPI has launched all waves of the workgroup
+ *          before any wave in the workgroup could end.  Without this, it is possible not all SGPRs get cleared.
+ *    2. Clean remaining SGPRs
+ *        Launches a workgroup with 24 waves per workgroup, yielding 6 waves per SIMD in each CU
+ *        Waves are allocating 96 SGPRs
+ *          CP sets up SPI_RESOURCE_RESERVE_* registers to prevent these waves from allocating SGPRs 0-223.
+ *          As such, these 6 waves per SIMD are allocated physical SGPRs 224-799
+ *       Barriers do not work for >16 waves per workgroup, so we cannot start with S_BARRIER
+ *       Instead, the shader starts with an S_SETHALT 1. Once all waves are launched CP will send unhalt command
+ *       The shader then clears all SGPRs allocated to it, cleaning out physical SGPRs 224-799
+ */
  
 shader main
   asic(MI300)
   type(CS)
   wave_size(64)
-// Note: original source code from SQ team
 
-//   (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 2176 clks)
+/*
+ * Note: original source code from SQ team
+ *
+ * (theorhetical fastest = ~512clks vgpr + 1536 lds + ~128 sgpr  = 2176 clks)
+ */
 
-  s_cmp_eq_u32 s0, 1                                // Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3
-  s_cbranch_scc0  label_0023                        // Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s3 == 1)
+  s_cmp_eq_u32 s0, 1                                /* Bit0 is set, sgpr0 is set then clear VGPRS and LDS as FW set COMPUTE_USER_DATA_3 */
+  s_cbranch_scc0  label_0023                        /* Clean VGPRs and LDS if sgpr0 of wave is set, scc = (s3 == 1) */
   S_BARRIER
 
   s_movk_i32    m0, 0x0000
-  s_mov_b32     s2, 0x00000078  // Loop 128/8=16 times  (loop unrolled for performance)
-  //
-  // CLEAR VGPRs
-  //
-  s_set_gpr_idx_on  s2, 0x8    // enable Dest VGPR indexing
+  s_mov_b32     s2, 0x00000078  /* Loop 128/8=16 times  (loop unrolled for performance) */
+/*
+ * CLEAR VGPRs
+ */
+  s_set_gpr_idx_on  s2, 0x8    /* enable Dest VGPR indexing */
 label_0005:
   v_mov_b32     v0, 0
   v_mov_b32     v1, 0
@@ -75,24 +80,24 @@ label_0005:
   s_set_gpr_idx_idx  s2
   s_cbranch_scc0  label_0005
   s_set_gpr_idx_off
- 
-  //
-  //
- 
-  s_mov_b32     s2, 0x80000000                      // Bit31 is first_wave
-  s_and_b32     s2, s2, s1                          // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
-  s_cbranch_scc0  label_clean_sgpr_1                // Clean LDS if its first wave of ThreadGroup/WorkGroup
-  // CLEAR LDS
-  //
+
+  s_mov_b32     s2, 0x80000000                      /* Bit31 is first_wave */
+  s_and_b32     s2, s2, s1                          /* sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set */
+  s_cbranch_scc0  label_clean_sgpr_1                /* Clean LDS if its first wave of ThreadGroup/WorkGroup */
+/*
+ * CLEAR LDS
+ */
   s_mov_b32 exec_lo, 0xffffffff
   s_mov_b32 exec_hi, 0xffffffff
-  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          // Set V1 to thread-ID (0..63)
-  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         // Set V1 to thread-ID (0..63)
-  v_mul_u32_u24  v1, 0x00000008, v1           // * 8, so each thread is a double-dword address (8byte)
-  s_mov_b32     s2, 0x00000003f               // 64 loop iteraions
+  v_mbcnt_lo_u32_b32  v1, exec_hi, 0          /* Set V1 to thread-ID (0..63) */
+  v_mbcnt_hi_u32_b32  v1, exec_lo, v1         /* Set V1 to thread-ID (0..63) */
+  v_mul_u32_u24  v1, 0x00000008, v1           /* * 8, so each thread is a double-dword address (8byte) */
+  s_mov_b32     s2, 0x00000003f               /* 64 loop iteraions */
   s_mov_b32     m0, 0xffffffff
-  // Clear all of LDS space
-  // Each FirstWave of WorkGroup clears 64kbyte block
+/*
+ * Clear all of LDS space
+ * Each FirstWave of WorkGroup clears 64kbyte block
+ */
  
 label_001F:
   ds_write2_b64  v1, v[2:3], v[2:3] offset1:32
@@ -100,11 +105,11 @@ label_001F:
   v_add_co_u32     v1, vcc, 0x00000400, v1
   s_sub_u32     s2, s2, 1
   s_cbranch_scc0  label_001F
-  //
-  // CLEAR SGPRs
-  //
+/*
+ * CLEAR SGPRs
+ */
 label_clean_sgpr_1:
-  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop unrolled for performance)
+  s_mov_b32     m0, 0x0000005c   /* Loop 96/4=24 times  (loop unrolled for performance) */
   s_nop 0
 label_sgpr_loop:
   s_movreld_b32     s0, 0
@@ -114,25 +119,25 @@ label_sgpr_loop:
   s_sub_u32         m0, m0, 4
   s_cbranch_scc0  label_sgpr_loop
  
-  //clear vcc, flat scratch
-  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR 
-  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR 
-  s_mov_b64 vcc, 0               //clear vcc
-  s_mov_b64 ttmp0, 0             //Clear ttmp0 and ttmp1 
-  s_mov_b64 ttmp2, 0             //Clear ttmp2 and ttmp3 
-  s_mov_b64 ttmp4, 0             //Clear ttmp4 and ttmp5 
-  s_mov_b64 ttmp6, 0             //Clear ttmp6 and ttmp7 
-  s_mov_b64 ttmp8, 0             //Clear ttmp8 and ttmp9 
-  s_mov_b64 ttmp10, 0            //Clear ttmp10 and ttmp11 
-  s_mov_b64 ttmp12, 0            //Clear ttmp12 and ttmp13 
-  s_mov_b64 ttmp14, 0            //Clear ttmp14 and ttmp15 
+  /* clear vcc, flat scratch */
+  s_mov_b32 flat_scratch_lo, 0   /* clear flat scratch lo SGPR */
+  s_mov_b32 flat_scratch_hi, 0   /* clear flat scratch hi SGPR */
+  s_mov_b64 vcc, 0               /* clear vcc */
+  s_mov_b64 ttmp0, 0             /* Clear ttmp0 and ttmp1 */
+  s_mov_b64 ttmp2, 0             /* Clear ttmp2 and ttmp3 */
+  s_mov_b64 ttmp4, 0             /* Clear ttmp4 and ttmp5 */
+  s_mov_b64 ttmp6, 0             /* Clear ttmp6 and ttmp7 */
+  s_mov_b64 ttmp8, 0             /* Clear ttmp8 and ttmp9 */
+  s_mov_b64 ttmp10, 0            /* Clear ttmp10 and ttmp11 */
+  s_mov_b64 ttmp12, 0            /* Clear ttmp12 and ttmp13 */
+  s_mov_b64 ttmp14, 0            /* Clear ttmp14 and ttmp15 */
 s_endpgm
 
 label_0023:
 
   s_sethalt 1
 
-  s_mov_b32     m0, 0x0000005c   // Loop 96/4=24 times  (loop unrolled for performance)
+  s_mov_b32     m0, 0x0000005c   /* Loop 128/8=16 times  (loop unrolled for performance) */
   s_nop 0
 label_sgpr_loop1:
 
@@ -143,10 +148,10 @@ label_sgpr_loop1:
   s_sub_u32         m0, m0, 4
   s_cbranch_scc0  label_sgpr_loop1
  
-  //clear vcc, flat scratch
-  s_mov_b32 flat_scratch_lo, 0   //clear  flat scratch lo SGPR 
-  s_mov_b32 flat_scratch_hi, 0   //clear  flat scratch hi SGPR 
-  s_mov_b64 vcc, 0xee            //clear vcc
+  /* clear vcc, flat scratch */
+  s_mov_b32 flat_scratch_lo, 0   /* clear  flat scratch lo SGPR */
+  s_mov_b32 flat_scratch_hi, 0   /* clear  flat scratch hi SGPR */
+  s_mov_b64 vcc, 0xee            /* clear vcc */
 
 s_endpgm
 end  
-- 
2.34.1

