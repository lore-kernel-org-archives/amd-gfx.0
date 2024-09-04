Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF4BCA0ED3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Sep 2024 09:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CDC10E720;
	Wed,  4 Sep 2024 09:51:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FEXdg8Y6";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D8F210E720
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Sep 2024 09:51:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=trJjHPswug2k7ONlb54pfRibGUZFenGnWid67r3IsJBSJTq+Y+9VzQaQEKHX2FLZi4aLCv06Lf5I1ft9ecLvYdG4N657HG1j4rf/ApeFosd/IvCpW1XVMWlfX8q2HT7I0A398ifHqyeg7oxyjpX4w2NXI9ZS/iV87cxqs/+zxGLkgz6ip43Y4iK82aCYiDK9c0D/2TsEbbUQpuc9B5xLrOHwQ6Ezg4xgbLA2myALgWCajmbTOIUxbX9231kBfWrUf6sc55AOHd/nuLlzWAxGa7mKQzP3O2uJZ+siPkNA0Lfys7N+9eJyilrogxM2JQ20roZCWR3kIAMjCIn1vCM0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC/eAecYNZ7K2z07M0JRZOay+rVKIOD1qT3RSU4Buws=;
 b=PxE4Z4WfST60RxEONvERxsUjoVgt2evlFI4/Ji7/ASQ8XgF3YTJ09X47clAboVQkB2LTtKbAJwJ0VFveLJBEj8OpzCJxFRbNUTNoqgPJAGRCUjssSR11Wwg/XvdIgjq2IxnDPhDlN0g3pLZ5jYRrsnzeo+oPLnV0LXvchf6Uul2GuOK02/s03j0Gql11AFiOx2VUz85Uhhplj+dgzRK0B1a7cdtst4++mIoGW5QjTecUwQNbZRzkTylalQlGNmA5oGbTIzklvFW++pcIAZRduY5JHERI0tDOHtx7DHdzQMFWQ5pC2GPmbfqzY2ZqNRFvDm7V65crkIPdKwDHf2/Few==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC/eAecYNZ7K2z07M0JRZOay+rVKIOD1qT3RSU4Buws=;
 b=FEXdg8Y6NltZoW3CKalvqilYlkNz5hlepQq7g4g03zcca2S8yx7cWTMr/UU0u7ziUxcHU8lGUGAz9VMnNGavB2HUBiXjLvQIVfVu2zvtGq0ByHoGaQtR7H2RQfu6AsWNdZoVKrhgWRyVeg8jF8G4Ft0XCvSWdHgBbeiwAYkk4PQ=
Received: from SJ0P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::21)
 by CY8PR12MB7754.namprd12.prod.outlook.com (2603:10b6:930:86::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 4 Sep
 2024 09:51:36 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::d2) by SJ0P220CA0023.outlook.office365.com
 (2603:10b6:a03:41b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Wed, 4 Sep 2024 09:51:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 09:51:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 04:51:33 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v2] drm/amdgpu/gfx9: Convert `//` to `/* ... */` in cleaner
 shader code
Date: Wed, 4 Sep 2024 15:21:20 +0530
Message-ID: <20240904095120.1813377-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|CY8PR12MB7754:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af6450d-4c22-478a-c576-08dcccc72a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTI2Z3hHeVowY3AzLzhPcXhuZFJENVkvRzdleHRzZWZpeHdQY21ZZXdwbkFt?=
 =?utf-8?B?b3FVU1A2bW1panNCSmNPdzloQm90QnRHSG9ZSDVBUENGZEtteWc3YkRqWHZJ?=
 =?utf-8?B?UTNDOS82QVMyOVh6bjRQYS8wSFdmQmgrUmFEYktSU2hkMkNEdDd0cnBoWVA4?=
 =?utf-8?B?V2JOTFhEYmsxYmR6cVVicU51RUcrb0JPUENwNGpxQ0NNZ0YwNDRPSFhPbUxz?=
 =?utf-8?B?QUdwMnJ2UVhvMFUzaEhiRkk2THRGb0dQOHhuRVJaQ3Nhcll2UjRxcXY0d25o?=
 =?utf-8?B?Q2xhSGlqYzFUQkZXNmc1eEQ4Qyt1ZUk0Qm1rRFFnSnM2SEpIVkRmSDBKMU9B?=
 =?utf-8?B?SFpJQXBoK0lKVTVVUHBjQ3hKUlFHU2hYM3NsTjd2VHMveWJvcVhNSzZYdlVP?=
 =?utf-8?B?dnVlL1ZoSXZSdU5WMmpZaXFoUC8raE42aUJmUk1QVmVCYmRrVE5SZlBDMzlX?=
 =?utf-8?B?TG1abmhGM2krTlhPbWZPV3dNVG9naXM0SjRvdjRIWUV1U2Z4RSszU20zK09Z?=
 =?utf-8?B?Rnk4TU5MQkxBdE82cElZTEJ3dldCRlAzdzVpSE1iSDV3Q040UjJuVEdlZ2hU?=
 =?utf-8?B?MXIvb3M1WHNRUGpObFBGcEZGRkl5OUJYV013Zk5FeTg2NFpUODdKQTVtVjEy?=
 =?utf-8?B?aUhnTEFBeVA2YmVhamFiVE9MY1RVRmkzSisrOGUrVU9oLzYzazM0RjBFM2JC?=
 =?utf-8?B?ZkR4eGo0YUN4WmliZ1JNR3ZaeFdvY2V0Y2x5cDhSUlBobGwxUXJtWnZRRTZs?=
 =?utf-8?B?MlVKTW9EMVdQM3lCTkJPZElScys4dGJBZ1R2ZFlQUUVyWXphaW1uVnZ1ZnRz?=
 =?utf-8?B?YkhwV1FCNlJ3VHk3NmNHbWIrMEoza3V3eW0rSVE0cGxxS3c5Zko0T3lpbjFN?=
 =?utf-8?B?YkRzaFlwQ1NiL25Yc0hwUGxzSFgwODBnbE5SS2N6UFhSS0c3cHRvSjJjRHZO?=
 =?utf-8?B?QXl4YWd6RVBFRnlUeTQxQWVmQUF3Z0xLbFB2NDRockFXdUo4VGRtaU0xN2U3?=
 =?utf-8?B?NGdoS0ludG5hNWwyOGNqNHRSS1MxT3ovWXd0T244MHA4Z0VIZ0hHNFRmblNF?=
 =?utf-8?B?OXNrcWxhNTBRQmZHZzg0V25Zd2xKSGw1TkVxMzR3QlFZSERqeEZWUjAxNWtV?=
 =?utf-8?B?NERrSzlrYUxDeUFBT3RmOUFaV3hqay9Ya3hZazVzKzlCTTQ5ak8wNnhySzVF?=
 =?utf-8?B?UXpGR0VPdWRUa294NmRSd0FaRXpCcWxzQTJOOUpxRHRwWE5CRnVSYTBid2JE?=
 =?utf-8?B?cjVUc2JGZVVrb0Q1djNZUmVnNUN0amZ0RWpqc3NyaHNOMmwzTXUwTXEwVzU5?=
 =?utf-8?B?WlQwWHRndkNPOGQ3N0h1cnVRcklTbERNSE5MN3oxVWpHUWlPNG14V1djLzRo?=
 =?utf-8?B?MFhmSGZpeWNiVVlhSkc1RlVnOWp2cm1aY1dIdkVtcDlxTzJGamx4aXQ0amIz?=
 =?utf-8?B?Vk5LcEwwNEtmT2xkRkRqQTk2L2FUWVlzSE1GamRYcTd0ajk3clc5ZTFqcm9h?=
 =?utf-8?B?Y3BWVkc0S3AxaStwVzlicmVQQ2VKVE5vbWh3WWNvaVVDNWNrcTVlRFp0d0gv?=
 =?utf-8?B?cGY5SEpIM01JOHZZWWo4MTN4RlNFc0RSTW9QTkhONk9ydVVkdjZRU1JSck9a?=
 =?utf-8?B?K3VWU2tEdUtNQ3FZdVViY2NHOFEzS2thNjJWZnVWeGhlNSt3VHI1TGYvYjl4?=
 =?utf-8?B?M1pEeVRScHZHMmJCSnFrNjJ4ZUJ1bnNncGgwSk9aTVE5dFlLSlg0UkxXWG9G?=
 =?utf-8?B?U3lZY0s3UFY3d0pCaUh5MjhnRkRCQndXUGhNVjdCTGJEMlQzMjY2YitnMDcz?=
 =?utf-8?B?MUNnZWhRK2hiekV6TDJoMWpUS3d0eHBiaHNpRXhmT3kxa21HNThjeThRRHIv?=
 =?utf-8?B?VC9QZFE0b2NVc25OWFdlTkRCd2pEb0tGNmUrYnJ1NkxxNXlyb1pKMnhOdXV6?=
 =?utf-8?Q?pN+RZlWYyT0tYYHkvd1UQx1LgS3gWbY/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 09:51:35.8544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af6450d-4c22-478a-c576-08dcccc72a50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7754
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

Fixes: 3b721dfb2c95 ("drm/amdgpu/gfx9: Add cleaner shader for GFX9.4.3")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
 - Corrected typo for iteraions
 - Added fixes tag

 .../amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm  | 139 +++++++++---------
 1 file changed, 72 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3_cleaner_shader.asm
index d5325ef80ab0..8951b5a87ae1 100644
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
+  s_mov_b32     s2, 0x00000003f               /* 64 loop iterations */
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

