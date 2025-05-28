Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEAAC3ABB2
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 09:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A06910E550;
	Wed, 28 May 2025 09:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Dd6T14hU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5220E10E160
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 09:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOEAFVvMkNJiRmkXJX8mt38QiL0rSO26W0+qvjxlOmIqw0T3mj++DNn+QX4rKOizo6mGe4lUIx/l0LULQ8WYg5zr5ckMT5zZ0W4dl93tOBYw+Xk2fFZQwoeDiH5n5rt6HGf6FrahoNyqVjdTOshI4eWHTCLBpApT/38VSt9+Tky//ERTnSYbQmyf9N7LA1FccSeGO8ZRq1m3M4g4Tmdeme5ndf8vDenYBtqI8nlthDG0kYY/JxQWlgB9iiL58fIvU1SVWGW9krrrI/uDUb8oYHutXhPCRQ39KF/BcfGqr8B213pwiif1q+bhxLx9T/ShZteAzZi4D7z8P6z2Cm/rhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eNElJ5DJ3VbxyGo+j4UtpEnKjLtx0JHznJ2WVt5LhY=;
 b=LvJIOUZJjWU6WHIaGRWObJmBsmQa50QvTkp3+6ZNsnMTj2UiRvuDPTEDYz1l2qGmapu9z1n4dsM2IDXHlirPn1dXYm9bZztbdiB1y50Dz1hJLerHPBKw/65qLJLPEuy/EHRf7zJ5Hny0VN69DMYhsW0Muq3PuYuY/FQoYJLl5iOe+a+IaaxQL72rO/HOc/ZL1tXWgbo5J9GNjukzR1cNVoFz4c9h59dVyC7SKaDVwSnstbVYbqtaaDAeGZkNdgnFfSb8kuWUNTbmG92HBrg0IhU6Bqp73BhZez+pmAdna5rhM/A96gXw2HmV1qfhekbMfMxigZc+BQOpE4fkCDFk6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eNElJ5DJ3VbxyGo+j4UtpEnKjLtx0JHznJ2WVt5LhY=;
 b=Dd6T14hUxYzO/kaD+NuBt2Q9CrHx7yZIGR/4N/onuNpnZc/x7gB0A02KWm/4xTI4CjHGd5dkTk5yr+eBvnT5G6AKDnWp0CeYP7SG+5VkwUi3WJ3mD48kx+z2r1x/17jvw6wq4MmXlkxFMk0ZbFgCLhqANTq2q0DLlO9UjZaWxy0=
Received: from MW4PR03CA0043.namprd03.prod.outlook.com (2603:10b6:303:8e::18)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.26; Wed, 28 May
 2025 09:20:47 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::be) by MW4PR03CA0043.outlook.office365.com
 (2603:10b6:303:8e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 28 May 2025 09:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 09:20:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 May 2025 04:20:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 Manu Rastogi <manu.rastogi@amd.com>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu/gfx10: Refine Cleaner Shader for GFX10.1.10
Date: Wed, 28 May 2025 14:50:21 +0530
Message-ID: <20250528092021.4049705-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: ad93b29f-4d5f-4159-5204-08dd9dc8edec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ay9jd0Z0UStuRjJkZWo0c3E0SERVY2ZadGZVZkFkTmhYTkpUV0pDN29hZGJE?=
 =?utf-8?B?RWhBR215TTIvaCtRR01wQVZMeXhQdWxUaDY3bUNOaTRadG1TZlhBS3pQciti?=
 =?utf-8?B?UExmRHhLUU5wcldNbGVHQk9HTmR2VEhmcU9YK0JNWVJBRnQ1eFRkM0RlcmdD?=
 =?utf-8?B?eWNiSjhmSVFsaUt6bVlwTVpJcmFNWHdqQ3hWdTV3OHVlSFkvaWZXaVRWcTh1?=
 =?utf-8?B?K2lLc1NtNEFlMElPdnNMZkV6MGJVcXZlcFVaWG1RbUVXdTJBdEJiYWlNUTBL?=
 =?utf-8?B?aDJQRENwYzVGMGxCU1hoVHFnZm1IS3JSK2grTnhKUlMzRGZMbEFhWThlR3Jz?=
 =?utf-8?B?K1BNdG81REtoRXVGcmhhMXZvNFQ1b0xiaGpuY3AwRWVSTmN0WGNKMTgwYy9Q?=
 =?utf-8?B?bDBIYWRkMWdjS0szOGtpeGxzbDJZaDFWYURkVnExc2p5K2RWZ2F2bDcreTUr?=
 =?utf-8?B?aFpQRjJEdHV0Vmltdk8zdnJIVjgyQ09LU2c0MnpXVG9oRTJra1ZrSGhYdXpa?=
 =?utf-8?B?QnF4Mlg2RkR2ZFRjem5pNmZMZFdqUjkxTi80dHh3MHRleTVSZ3BhR3Zrc254?=
 =?utf-8?B?cTdkeXJXNDJWZkJMQkk0YzluYTFVbEpuVk02cUQwblVZL2Rta28rbkdCejJr?=
 =?utf-8?B?Z1BSdS9CL1owWHVkRklYemRPa3ZwZHJVTTVnZ2NpUmtWQWNsWkRkVlF6SmdK?=
 =?utf-8?B?ZHdqaUlqTGlObzl6OUlrd2hqdlJibHVTVjRBdk92UXJEVnJ4Qjdvc0RlY1Ux?=
 =?utf-8?B?NWhIVVg5aFp0N3liZmtpZ2hCSDYyOTFrRjhhNWNMeGIvREU5TGFSb3ZidGtW?=
 =?utf-8?B?OTJiYUYrYjRBSGNMMkVqZzJRWjBIcThIVzlkeFNqbi8zVERDVWlzalBzb0ZM?=
 =?utf-8?B?SDRWWm9nMk1ZdS9kbVZMUEhIRmRGcjdFOVFDMlo2a1FUVmFiRUdrMVBOR3hy?=
 =?utf-8?B?cEtPcTR6dW9QTHVWMW5HdjhwYVJLMGVYK0tReDRGN3hteFYxZUprNExYNzRK?=
 =?utf-8?B?YzVxRUh1MWJLb0k1d0FpelVqdHI2dEkxTkNpTFFUTkJqbGNYQXNhK0VPZUMw?=
 =?utf-8?B?YzA0REtHSE9rK3p5bmNxZFNOd2NWenRVTFdoVm1Nc1FJVldwR1grTVRQTEpn?=
 =?utf-8?B?TmUwQTJncE1Rd1hscHdQNG9pU3JzNE1TUGVYMmRzM0ZtYVAyTFpxV0o1WVp6?=
 =?utf-8?B?WHRQRFViNnZtTDdoNzRiaWxKT1ZkQm91RGhoZXlQZlpPUjZxU0J4dnRFL3Nh?=
 =?utf-8?B?Y2xibUVBcWZaaGsvU2hsd2h5engrRzROcUhXVDdISktmQ3lIQVg1T1liaXR4?=
 =?utf-8?B?OVNUMHVQNTlReEljRUJZZHB0K0lGRjhIUnBoaFlXNzdqelg5dVpocFhkd3N5?=
 =?utf-8?B?SC9jWFRmcjRlRjNaZXJXQmtoU21paTl6TGg5cy8zSWsvM1kvSG1TemJsU1kz?=
 =?utf-8?B?aXh5VHRRNmkrVVhmcHhNL0h4UUV3VnJlRW11OXk5eFBxb1MwZ1VVOUNxUzFq?=
 =?utf-8?B?K0wvUDg3cjdCUkl6Y2wyM2JTSGRhZHN2K0tnWnFHOEF0NEc2Q2FSMjJXeTJn?=
 =?utf-8?B?dVhxS3dyaGkrSUVxR3A4YWNHZHBydnIxVGFtYkhXaFM2THM4NmZNbVFyT3Qv?=
 =?utf-8?B?ZmpMWXc0QnVQNStXbDF5bm9KOWsrWHRZZVBMT3VzZm9rWFBuS1ZBUEp0UWVJ?=
 =?utf-8?B?NlBIb3hnNXp1WGhnVFJQYmxqNU1VaWQ4Y3M5WEJHS3Y0R2JLREVWUlB1ajU0?=
 =?utf-8?B?aElIUS9tVDBaM3p6OHpvbzA4N3RVdml2b3pPNEZoMXk3RzB0Wk1kS2tXQ0o1?=
 =?utf-8?B?NmQ0Uzc0dXhRQnQ2ZHJCZ1NUSitPc3lNSUlvT3dWVDgzV24vcXJIdGgvQitZ?=
 =?utf-8?B?aHZzUm0xellYR1BIN3BUME9IK2tzK0xMbUVsSXQyR0NLRlR6aGZFaTM4ZWY0?=
 =?utf-8?B?T0hTS3pkZlUwNnFQN3lkVlcydW5KTW0zTkxaVEZiMmVZczM2Rm5FSHBrWHBW?=
 =?utf-8?B?bWtVcjdCR3k4L0VyZ1V1am9hZHpST1l3UU9VRWFWNG9sUmVtRnN4REFIdUJC?=
 =?utf-8?Q?mMUCpC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 09:20:46.6546 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad93b29f-4d5f-4159-5204-08dd9dc8edec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

This patch updates the cleaner shader, which is responsible for
initializing GPU resources such as Local Data Share (LDS), Vector
General Purpose Registers (VGPRs), and Scalar General Purpose Registers
(SGPRs). Changes include adjustments to register clearing and shader
configuration.

- Updated GPU resource initialization addresses in the cleaner shader
  from `be803080` to `be803000`.
- Simplified the logic in the SGPR clearing section, ensuring all SGPRs
  are set to zero.

Fixes: 25961bad9212 ("drm/amdgpu/gfx10: Add cleaner shader for GFX10.1.10")
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Manu Rastogi <manu.rastogi@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h   |  6 +++---
 .../drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm  | 13 ++++++-------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
index 5255378af53c..f67569ccf9f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0_cleaner_shader.h
@@ -43,9 +43,9 @@ static const u32 gfx_10_1_10_cleaner_shader_hex[] = {
 	0xd70f6a01, 0x000202ff,
 	0x00000400, 0x80828102,
 	0xbf84fff7, 0xbefc03ff,
-	0x00000068, 0xbe803080,
-	0xbe813080, 0xbe823080,
-	0xbe833080, 0x80fc847c,
+	0x00000068, 0xbe803000,
+	0xbe813000, 0xbe823000,
+	0xbe833000, 0x80fc847c,
 	0xbf84fffa, 0xbeea0480,
 	0xbeec0480, 0xbeee0480,
 	0xbef00480, 0xbef20480,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
index 9ba3359253c9..54f7ed9e2801 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_1_10_cleaner_shader.asm
@@ -40,7 +40,6 @@ shader main
   type(CS)
   wave_size(32)
 // Note: original source code from SQ team
-
 //
 // Create 32 waves in a threadgroup (CS waves)
 // Each allocates 64 VGPRs
@@ -71,8 +70,8 @@ label_0005:
   s_sub_u32     s2, s2, 8
   s_cbranch_scc0  label_0005
   //
-  s_mov_b32     s2, 0x80000000                     // Bit31 is first_wave
-  s_and_b32     s2, s2, s0                                  // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
+  s_mov_b32     s2, 0x80000000                       // Bit31 is first_wave
+  s_and_b32     s2, s2, s1                           // sgpr0 has tg_size (first_wave) term as in ucode only COMPUTE_PGM_RSRC2.tg_size_en is set
   s_cbranch_scc0  label_0023                         // Clean LDS if its first wave of ThreadGroup/WorkGroup
   // CLEAR LDS
   //
@@ -99,10 +98,10 @@ label_001F:
 label_0023:
   s_mov_b32     m0, 0x00000068  // Loop 108/4=27 times  (loop unrolled for performance)
 label_sgpr_loop:
-  s_movreld_b32     s0, 0
-  s_movreld_b32     s1, 0
-  s_movreld_b32     s2, 0
-  s_movreld_b32     s3, 0
+  s_movreld_b32     s0, s0
+  s_movreld_b32     s1, s0
+  s_movreld_b32     s2, s0
+  s_movreld_b32     s3, s0
   s_sub_u32         m0, m0, 4
   s_cbranch_scc0  label_sgpr_loop
 
-- 
2.34.1

